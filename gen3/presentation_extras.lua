-- Presentation only: native turn logic, callbacks, stats and clocks are retained.
return function(R)
 local X={};local seen=setmetatable({},{__mode='k'})
 local unpack=table.unpack or unpack
 local function pack(...)return {n=select('#',...),...}end
 local sendDepth=0;local faint
 local function on()return not R.unloaded and R.glass()and R.option('battle',true)end
 local function scope(fn,...)
  sendDepth=sendDepth+1;local r=pack(pcall(fn,...));sendDepth=sendDepth-1
  if not r[1]then error(r[2],0)end;return unpack(r,2,r.n)
 end
 local function native()return R.module('src.core.game3.battle.init')end
 local function inBattle()local B=native();return on()and B and B.isActive and B.isActive()end
 function X.install()
  local A=R.module('src.core.game3.battle.anim')
  if A and not seen[A]then
   seen[A]=true
   R.wrap(A,'sendOutMon',function(next,...)
    if not inBattle()then return next(...)end
    local id=A.idOf(select(1,...))or 1;local p=A.present(id)
    if p then p.alpha=1;p.blendCoeff=0;p.scale=1 end
    return scope(next,...)
   end)
   R.wrap(A,'tweenStage',function(next,frames,update,done,...)
    if faint then
     local p=faint
     return next(20,function(u)
      p.oy=0;p.scale=math.max(.01,1-u);p.alpha=math.max(0,1-u)
      p.blendColor={1,1,1};p.blendCoeff=u<.35 and math.sin(u/.35*math.pi)or 0
     end,function(...)
      p.alpha=1;p.scale=1;p.visible=false;p.oy=0;p.blendCoeff=0
      if done then return done(...)end
     end,...)
    end
    if sendDepth>0 then
     local cb=done and function(...)return scope(done,...)end or nil
     return next(math.max(1,math.floor(frames*.5+.5)),update,cb,...)
    end
    return next(frames,update,done,...)
   end)
   R.wrap(A,'faintMon',function(next,key,...)
    local id=A.idOf(key or 'enemy')or 1
    if not inBattle()or id%2==0 then return next(key,...)end
    local previous=faint;faint=A.present(id)
    local r=pack(pcall(next,key,...));faint=previous
    if not r[1]then error(r[2],0)end;return unpack(r,2,r.n)
   end)
  end
  local Intro=R.module('src.core.game3.battle.intro_seq')
  if Intro and not seen[Intro]then seen[Intro]=true
   R.wrap(Intro,'begin',function(next,...)
    local r=pack(next(...))
    if on()then for _,step in ipairs(Intro._steps or {})do
     if step.kind=='wait' and step.data and tonumber(step.data.frames)then step.data.frames=math.max(1,math.floor(step.data.frames*.5+.5))end
    end end
    return unpack(r,1,r.n)
   end)
  end
  local C=R.module('src.ui.game3.battle_chrome')
  if C and not seen[C]then seen[C]=true
   R.wrap(C,'drawPartyBar',function(next,x,y,balls,ox,enemy,...)
    local B=native()
    if inBattle()and B._phase=='intro'then x=enemy and 152 or 8;y=8 end
    return next(x,y,balls,ox,enemy,...)
   end)
   R.wrap(C,'drawCleanBg',function(next,...)
    local old=X.bgDrawing;X.bgDrawing=true
    local r=pack(pcall(next,...));X.bgDrawing=old
    if not r[1]then error(r[2],0)end;return unpack(r,2,r.n)
   end)
  end
  local E=R.module('src.ui.game3.evolution_scene')
  if E and not seen[E]then seen[E]=true
   R.wrap(E,'draw',function(next,...)
    local g=love.graphics
    if not on()or not E.open or not(g.newCanvas and g.getCanvas and g.setCanvas and g.origin)then return next(...)end
    if not X.evo then X.evo=g.newCanvas(240,160,{dpiscale=1});X.bg=g.newCanvas(240,160,{dpiscale=1})end
    local previous=g.getCanvas();g.push('all');g.setCanvas(X.evo);g.origin();g.clear(0,0,0,0)
    X.capturing=true;X.copied=false
    local r=pack(pcall(next,...));X.capturing=false
    g.setCanvas(previous);g.pop()
    if not r[1]then error(r[2],0)end
    g.setColor(1,1,1,1);g.draw(X.evo,0,0)
    return unpack(r,2,r.n)
   end)
   R.wrap(love.graphics,'draw',function(next,img,...)
    if X.capturing and not X.bgDrawing and not X.copied then
     X.copied=true
     local g=love.graphics;local previous=g.getCanvas();g.push('all')
     g.setCanvas(X.bg);g.origin();g.setShader();g.clear(0,0,0,0);g.setColor(1,1,1,1)
     next(X.evo,0,0);g.setCanvas(previous);g.pop()
    end
    return next(img,...)
   end)
  end
 end
 function X.evolutionHud(w,h)
  local E=R.module('src.ui.game3.evolution_scene')
  if not(on()and E and E.open and X.evo and X.bg and X.copied)then return end
  local g=love.graphics;g.push('all');g.origin();g.setShader();g.setColor(1,1,1,1)
  local cover=math.max(w/240,h/112);local fit=math.min(w/240,h/160)
  -- The background snapshot ends before the first Pokémon draw. No oversized
  -- Pokémon copy is stretched behind the native evolution scene.
  local q=X.bgQuad
  if not q then q=g.newQuad(0,0,240,112,240,160);X.bgQuad=q end
  g.draw(X.bg,q,(w-240*cover)/2,(h-112*cover)/2,0,cover,cover)
  if g.setBlendMode then g.setBlendMode('alpha','premultiplied')end
  g.draw(X.evo,(w-240*fit)/2,(h-160*fit)/2,0,fit,fit)
  g.pop()
 end
 local stats={{'HP','hp'},{'ATK','atk'},{'DEF','def'},{'SPA','spa'},{'SPD','spd'},{'SPE','spe'}}
 function X.ivEv(layout,st,w,h)
  if not R.option('opponent_iv_ev',false)or not layout or not layout.settings or not(st and st.enemy and st.enemy.mon)then return end
  local foe=st.enemy
  if st.double and tonumber(foe.mon.hp)==0 and st.battlers and st.battlers[3] and st.battlers[3].mon then foe=st.battlers[3]end
  local mon=foe.mon;local g=love.graphics;local a=layout.settings
  local width=math.min(w-12,math.max(a.w,340));local x=math.max(6,math.min(w-width-6,a.x+a.w-width));local y=a.y+a.h+6
  local size=math.floor(math.max(9,math.min(14,width/30))+.5);local rowH=size+12
  if y+rowH*2>h then return end
  if not X.font or X.fontSize~=size then if X.font and X.font.release then X.font:release()end;X.font=g.newFont(size);X.fontSize=size end
  g.push('all');g.setFont(X.font)
  for i,kind in ipairs({'IV','EV'})do
   local yy=y+(i-1)*(rowH+3);local values=mon[kind=='IV'and 'ivs'or 'evs']
   g.setColor(.045,.10,.12,.94);g.rectangle('fill',x,yy,width,rowH,4,4)
   g.setColor(.85,.9,.85,1);g.rectangle('line',x+.5,yy+.5,width-1,rowH-1,4,4)
   g.print(kind,x+6,yy+5)
   for j,s in ipairs(stats)do
    local v=type(values)=='table'and tonumber(values[s[2]])or nil
    g.print(s[1]..':'..(v and tostring(math.floor(v))or '—'),x+32+(j-1)*(width-38)/6,yy+5)
   end
  end
  g.pop()
 end
 function X.shutdown()
  for _,key in ipairs({'evo','bg','bgQuad','font'})do if X[key]and X[key].release then X[key]:release()end;X[key]=nil end
 end
 return X
end
