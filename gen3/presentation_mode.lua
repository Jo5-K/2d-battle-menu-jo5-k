-- Both mods stay loaded. Only their battle presentation is exclusive.
return function(R)
 local own=R.mod.id
 local a,b='battle_menu_2d_jo5k','battle_menu_25d_jo5k'
 local other=own==a and b or a
 local C={busy=false}
 local function present(id)
  if id==own then return true end
  local found=R.mod.find and R.mod.find(id)
  return found and found.exports and found.exports.gen3 and not found.exports.gen3.diagnostics().unloaded
 end
 local function enabled(id)
  local g=R.mod.game;local options=g and g.mods and g.mods.modOptions
  local v=options and options[id]and options[id].gen3_battle
  if v==nil then return id==a end
  return v==true
 end
 function C.current()
  if present(b)and enabled(b)then return b end
  if present(a)and enabled(a)then return a end
 end
 function C.owns()return C.current()==own end
 function C.select(id)
  if id=='2d'then id=a elseif id=='2.5d'then id=b end
  if id~='native'and not present(id)then return false end
  if C.busy then return true end;C.busy=true
  local g=R.mod.game;local Manager=R.module('src.mods.ManagerState')
  local ok,err=pcall(function()
   if not(g and g.save and g.mods and Manager)then error('Gerenciador de opções indisponível')end
   local manager=Manager.new(g)
   local value=id==a and '2d'or id==b and '2.5d'or 'native'
   for _,target in ipairs({a,b})do if present(target)then
    local handle=R.mod.find and R.mod.find(target)
    if handle and handle.exports and handle.exports.gen3 and handle.exports.gen3.resetPresentation then handle.exports.gen3.resetPresentation()end
    local bucket=g.mods.modOptions[target]or {}
    if bucket.gen3_battle~=(target==id)then manager:setOption(target,'gen3_battle',target==id)end
    if bucket.gen3_presentation_mode~=value then manager:setOption(target,'gen3_presentation_mode',value)end
   end end
  end)
  C.busy=false
  if not ok then R.warn('battle mode selection',err);return false end
  return true
 end
 local stop=R.mod.events:on('mod.options_changed',function(e)
  if not C.busy and e and e.mod==own and e.key=='gen3_battle'and e.value==true then C.select(own)end
 end)
 function C.stop()if stop then stop();stop=nil end end
 return C
end
