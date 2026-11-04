-- Gen3 graphical integration, Gen1Recomp >=0.3.97.
return function(mod)
  local game=require('src.core.GameVersion').get()
  if not ({firered=true,leafgreen=true,ruby=true,sapphire=true,emerald=true})[game] then return end
  local version=require('src.core.Version').engine
  assert(require('src.mods.Semver').satisfies(version,'>=0.3.97'),
    '2D Battle Menu - Jo5-k requires Gen1Recomp >=0.3.97; found '..tostring(version))
  local function loadPart(path)
    return assert(load(assert(mod:read(path)),'@battle_menu_2d_jo5k/'..path))()
  end
  local R={mod=mod,version='1.0.0-rc.4',engine=version,depth=0,patches={},warnings={}}
  R.load=loadPart
  assert(mod.manifest==nil or mod.manifest.api==3,'This build requires the API 3 manifest')
  -- The bare sandbox omits package; Loader's legacy compat supplies only an
  -- isolated, empty package.loaded, never the engine's live module cache.
  -- Engine modules must be acquired through its permitted require function.
  local modules={}
  function R.module(name)
    if modules[name] then return modules[name] end
    local ok,value=pcall(require,name)
    if ok and type(value)=='table' then modules[name]=value;return value end
    R.warn('module '..name,ok and 'Module did not return a table' or value)
    return nil
  end
  function R.active()
    local id=require('src.core.GameVersion').get()
    return not R.unloaded and (not R.mode or R.mode.owns()) and ({firered=true,leafgreen=true,ruby=true,sapphire=true,emerald=true})[id]==true
  end
  function R.option(key,default)
    if key=='presentation_mode'and R.mode then return R.mode.current()=='battle_menu_25d_jo5k'and '2.5d'or R.mode.current()=='battle_menu_2d_jo5k'and '2d'or 'native' end
    local value=mod.options:get('gen3_'..key)
    if value==nil then return default end
    return value
  end
  -- The public options handle still exposes define/get in v0.3.97.
  -- Use the same native writer as the mod manager, including persistence/events.
  function R.setOption(key,value)
    if key=='presentation_mode'and R.mode then return R.mode.select(value)end
    local game=R.game
    local Manager=R.module('src.mods.ManagerState')
    if not game or not game.mods or not game.save or not game.save.options
      or not Manager or type(Manager.new)~='function' then
      R.warn('settings unavailable','Native game/options manager is not ready');return false
    end
    local ok,result=pcall(function() return Manager.new(game):setOption(mod.id,'gen3_'..key,value) end)
    if not ok then R.warn('settings write',result);return false end
    return result~=false
  end
  function R.glass() return R.active() and R.option('theme','floating_glass')=='floating_glass' end
  function R.warn(key,err)
    if R.warnings[key] then return end
    R.warnings[key]=tostring(err)
    if mod.log then mod.log:warn('2D Battle Menu %s: %s',key,tostring(err)) end
  end
  R.subscriptions={}
  local function remember(stop)
    if type(stop)=='function'then R.subscriptions[#R.subscriptions+1]=stop end
    return stop
  end
  function R.on(name,callback,priority)return remember(mod.events:on(name,callback,priority))end
  function R.hook(name,callback,priority)return remember(mod.hooks:wrap(name,callback,priority))end
  function R.wrap(target,key,wrapper)
    if type(target)~='table' or type(target[key])~='function' then return false end
    local original=target[key]
    local fn=function(...)
      if not R.active() then return original(...) end
      return wrapper(original,...)
    end
    target[key]=fn;R.patches[#R.patches+1]={target,key,original,fn}
    return true
  end
  function R.scope(fn,...)
    R.depth=R.depth+1
    love.graphics.push('all')
    local ok,a,b,c=pcall(fn,...)
    love.graphics.pop();R.depth=R.depth-1
    if not ok then error(a,0) end
    return a,b,c
  end
  local cameraChoices={{'AUTO BY GAME','auto'}}
  for _,e in ipairs(loadPart('gen3/background_catalog.lua').entries) do cameraChoices[#cameraChoices+1]={e.label,e.id} end
  local preferenceSchema={
    {key='gen3_battle_camera',label='BATTLE CAMERA',type='choice',default='native',group='GEN 3 / BATTLE',choices={{'NATIVE','native'},{'ORIGINAL','current'},{'G9 / HD COMPATIBILITY','g9_compat'},{'FOREGROUND','native_depth'}}},
    {key='gen3_shadows',label='SPRITE SHADOWS',type='choice',default='auto',group='GEN 3 / BATTLE',choices={{'AUTO: CAMERA POLICY','auto'},{'ENEMIES','enemies'},{'BOTH','both'}}},
    {key='gen3_shadow_anchor',label='SHADOW CONTACT',type='choice',default='feet',group='GEN 3 / BATTLE',choices={{'FEET','feet'},{'KNEES','knees'}}},
    {key='gen3_camera_background',label='BACKGROUND 21:9',type='choice',default='auto',group='GEN 3 / SCENERY',choices=cameraChoices},
    {key='gen3_theme',label='BATTLE UI THEME',type='choice',default='floating_glass',group='GEN 3 / APPEARANCE',choices={{'FLOATING GLASS','floating_glass'},{'ORIGINAL','native'}}},
    {key='gen3_battle',label='GEN3 FLOATING BATTLE',type='toggle',default=true,group='GEN 3 / BATTLE',description='Custom single and double battle interface. Special native screens retain safe controls.'},
    {key='gen3_battle_layout',label='BUTTON LAYOUT',type='choice',default='layers',group='GEN 3 / BATTLE',choices={{'CARTAS EM CAMADAS','layers'},{'LISTA FLUTUANTE','list'},{'COMMAND MENU (FIGHT)','commands'},{'JOURNAL GRID (2 × 2)','journal'}}},
    {key='gen3_lighting_profile',label='LIGHT PROFILE',type='choice',default='auto',group='GEN 3 / LIGHTING',choices={{'LOCAL TIME','auto'},{'PREDAWN','predawn'},{'DAWN','dawn'},{'MORNING','morning'},{'NOON','noon'},{'DUSK','dusk'},{'NIGHT','night'}}},
    {key='gen3_lighting_intensity',label='LIGHT INTENSITY',type='choice',default=.75,group='GEN 3 / LIGHTING',choices={{'25%',.25},{'50%',.5},{'75%',.75},{'100%',1}}},
    {key='gen3_lighting_ambient',label='AMBIENT BRIGHTNESS',type='choice',default=.75,group='GEN 3 / LIGHTING',choices={{'50%',.5},{'75%',.75},{'100%',1}}},
    {key='gen3_lighting_rim',label='RIM LIGHT',type='choice',default=.5,group='GEN 3 / LIGHTING',choices={{'OFF',0},{'25%',.25},{'50%',.5},{'75%',.75}}},
    {key='gen3_lighting_relief',label='APPROXIMATE RELIEF',type='choice',default=.5,group='GEN 3 / LIGHTING',choices={{'OFF',0},{'25%',.25},{'50%',.5},{'75%',.75}}},
    {key='gen3_lighting_direction',label='LIGHT DIRECTION',type='choice',default='auto',group='GEN 3 / LIGHTING',choices={{'AUTO','auto'},{'LEFT','left'},{'RIGHT','right'},{'TOP','top'}}},
    {key='gen3_lighting_beams',label='POST-SPRITE LIGHT RAYS',type='toggle',default=true,group='GEN 3 / LIGHTING'},
    {key='gen3_lighting_hud_glint',label='HUD COUNTER-DIRECTION GLINT',type='toggle',default=true,group='GEN 3 / LIGHTING'},
    {key='gen3_lighting_local',label='LOCAL LIGHTING',type='toggle',default=true,group='GEN 3 / LIGHTING'},
    {key='gen3_environment_sprites',label='ENVIRONMENT ANIMATIONS',type='toggle',default=true,group='GEN 3 / BATTLE'},
    {key='gen3_environment_pokemon',label='DECORATIVE POKEMON',type='toggle',default=true,group='GEN 3 / BATTLE'},
    {key='gen3_portrait_frame',label='PORTRAIT FRAME',type='toggle',default=true,group='GEN 3 / BATTLE'},
    {key='gen3_cave_lighting',label='CAVE INTERNAL LIGHTING',type='toggle',default=true,group='GEN 3 / BATTLE'},
    {key='gen3_dynamic_lighting',label='DYNAMIC LIGHTING',type='toggle',default=true,group='GEN 3 / BATTLE'},
    {key='gen3_dialogue_size',label='BATTLE MESSAGE SIZE',type='choice',default='medium',group='GEN 3 / BATTLE',choices={{'SMALL (PREVIOUS)','small'},{'MEDIUM','medium'},{'MEDIUM LARGE','medium_large'},{'LARGE','large'}}},
    {key='gen3_command_scale',label='COMMAND MENU SIZE',type='choice',default=1,group='GEN 3 / BATTLE',choices={{'75%',.75},{'100%',1},{'125%',1.25},{'150%',1.5},{'175%',1.75}}},
    {key='gen3_battle_opacity',label='MOVE CARD OPACITY',type='choice',default=.70,group='GEN 3 / BATTLE',choices={{'70%',.70},{'55%',.55},{'85%',.85}}},
    {key='gen3_battle_scale',label='BATTLE UI SIZE',type='choice',default=.68,group='GEN 3 / BATTLE',choices={{'NORMAL',.68},{'SMALL',.58},{'LARGE',.78}}},
    {key='gen3_battle_position',label='BATTLE UI POSITION',type='choice',default='left',group='GEN 3 / BATTLE',choices={{'LEFT','left'},{'RIGHT','right'}}},
    {key='gen3_scenery',label='LAYERED SCENERY',type='choice',default='auto',group='GEN 3 / SCENERY',choices={{'AUTO','auto'},{'NATIVE / OTHER MODS','native'}}},
    {key='gen3_button_palette',label='BUTTON PALETTE',type='choice',default='pastel',group='GEN 3 / BATTLE',choices={{'NEUTRAL PASTEL','pastel'},{'METAL','metal'}}},
    {key='gen3_lens_size',label='FOREGROUND SIZE',type='choice',default=.65,group='GEN 3 / SCENERY',choices={{'SMALL',.65},{'MEDIUM',.8},{'ORIGINAL',1}}},
    {key='gen3_lens_motion',label='GENTLE FOREGROUND MOTION',type='toggle',default=true,group='GEN 3 / SCENERY'},
    {key='gen3_foreground',label='FOREGROUND',type='choice',default=.65,group='GEN 3 / SCENERY',choices={{'65%',.65},{'OFF',0},{'100%',1}}},
    {key='gen3_battle_aspect',label='BATTLE ASPECT',type='choice',default='window',group='GEN 3 / BATTLE',choices={{'WINDOW','window'},{'NATIVE 3:2','native'},{'4:3','4:3'},{'16:9','16:9'},{'19:9','19:9'}}},
    {key='gen3_battle_skin',label='BATTLE COLOR STYLE',type='choice',default='current',group='GEN 3 / BATTLE',choices={{'CURRENT','current'},{'EMERALD GREEN & IVORY','emerald_ivory'},{'CLASSIC COLORS','classic'},{'EMERALD GBA','emerald_gba'},{'CRYSTAL GLASS','crystal_glass'}}},
    {key='gen3_battle_menu_skin',label='BATTLE MENU THEME',type='choice',default='crystal_glass',group='GEN 3 / BATTLE',choices={{'CRYSTAL GLASS','crystal_glass'},{'EMERALD GREEN & IVORY','emerald_ivory'},{'EMERALD GBA','emerald_gba'}}},
    {key='gen3_settings_language',label='SETTINGS LANGUAGE / IDIOMA',type='choice',default='pt-BR',group='GEN 3 / BATTLE',choices={{'PT-BR','pt-BR'},{'English','en'},{'Français','fr'},{'Español','es'}}},
    {key='gen3_battle_drop',label='LOWER BATTLERS',type='choice',default=8,group='GEN 3 / BATTLE',choices={{'8 PX',8},{'12 PX',12},{'16 PX',16},{'20 PX',20},{'NATIVE',0}}},
    {key='gen3_battle_extend',label='EXTEND NATIVE BATTLE FIELD',type='toggle',default=true,group='GEN 3 / BATTLE',description='Continue native wallpaper under the former GBA command panel; disable if another scenery mod supplies that area.'},
    {key='gen3_opponent_iv_ev',label='OPPONENT IV / EV',type='toggle',default=false,group='GEN 3 / BATTLE'},
    {key='gen3_caught',label='SHOW CAUGHT POKEMON',type='toggle',default=true,group='GEN 3 / BATTLE'},
    {key='gen3_remember_move',label='REMEMBER LAST MOVE',type='toggle',default=true,group='GEN 3 / BATTLE'},
    {key='gen3_sprite_source',label='GEN3 POKEMON SPRITES',type='choice',default='native',group='GEN 3 / GRAPHICS',choices={{'ORIGINAL / OTHER MODS','native'},{'KRS STATIC ART','krs'}},description='KRS uses individually cropped static frames, never full animation sheets. Missing species and special forms keep native art.'},
    {key='gen3_front_generation',label='KRS FRONT GENERATION',type='choice',default='5',group='GEN 3 / GRAPHICS',choices={{'GEN 1','1'},{'GEN 2','2'},{'GEN 3','3'},{'GEN 4','4'},{'GEN 5','5'}}},
    {key='gen3_back_generation',label='KRS BACK GENERATION',type='choice',default='5',group='GEN 3 / GRAPHICS',choices={{'GEN 1','1'},{'GEN 2','2'},{'GEN 3','3'},{'GEN 4','4'},{'GEN 5','5'}}},
  }
  table.insert(preferenceSchema,1,{key='gen3_presentation_mode',label='BATTLE PRESENTATION / MODO DE BATALHA',type='choice',default='2d',choices={{'2D','2d'},{'2.5D','2.5d'},{'NATIVE','native'}}})
  mod.options:define(preferenceSchema)
  R.mode=loadPart('gen3/presentation_mode.lua')(R)
  R.on('mod.options_changed',function(e)if e and e.mod==mod.id and e.key=='gen3_presentation_mode'then R.mode.select(e.value)end end)
  -- Inherit only unset presentation preferences. Never write the original
  -- namespace, nor overwrite choices already made in this independent copy.
  function R.inheritPresentation()
    if R.inherited then return end
    local g=R.game;local options=g and g.mods and g.mods.modOptions
    if not options then return end
    local old=options.floating_glass_frlg
    if type(old)~='table'then R.inherited=true;return end
    local own=options[mod.id]or {};local complete=true
    for _,row in ipairs(preferenceSchema)do
      if own[row.key]==nil and old[row.key]~=nil then
        if not R.setOption(row.key:sub(6),old[row.key])then complete=false end
      end
    end
    R.inherited=complete
  end
  R.capabilities={}
  function R.supports(surface,name)
    local key=surface..':'..name
    local row=R.capabilities[key]
    if row then return row.supported,row.reason end
    local ok,why=mod:supports(surface,name)
    R.capabilities[key]={supported=ok==true,reason=why}
    return ok==true,why
  end
  for _,name in ipairs({'input.step','input.pointer','render.viewport','render.hud','pokemon.sprite','core.quit_to_launcher'})do
    local ok,why=R.supports('hooks',name)
    assert(ok,'Required API3 hook unavailable: '..name..' / '..tostring(why))
  end
  -- Temporary battle-only scope requested by the user. Outside menus stay native.
  R.outsideBattleUI=false
  R.portrait=loadPart('gen3/portrait.lua')(R)
  R.camera=loadPart('gen3/camera.lua')(R)
  R.compat=loadPart('gen3/sprite_compat.lua')(R)
  R.shadows=loadPart('gen3/shadows.lua')(R)
  R.theme=loadPart('gen3/theme.lua')()
  R.framing=loadPart('gen3/framing.lua')(R)
  R.lighting=loadPart('gen3/lighting.lua')(R)
  R.postLight=loadPart('gen3/post_light.lua')(R)
  R.ambient=loadPart('gen3/ambient_layers.lua')(R)
  R.details=loadPart('gen3/scene_details.lua')(R)
  R.scenery=loadPart('gen3/scenery.lua')(R)
  R.art=loadPart('gen3/art.lua')(R)
  R.battle=loadPart('gen3/battle.lua')(R)
  R.extras=loadPart('gen3/presentation_extras.lua')(R)
  R.stopSummary=loadPart('gen3/summary_background.lua')(R.wrap,function(m)
   local B=R.module('src.core.game3.battle.init');local E=R.module('src.ui.game3.evolution_scene')
   return R.glass()and R.option('battle',true)and ((B and B.isActive and B.isActive())or(E and E.open and E._isBattle)or(R.battleScreens and R.battleScreens.origins[m]))
  end,function()
   local t=R.option('battle_menu_skin','crystal_glass')
   return t=='crystal_glass'and {.86,.94,1}or t=='emerald_gba'and {.32,.42,.39}or {.21,.42,.35}
  end)
  R.battleTouch=loadPart('gen3/battle_touch.lua')(R)
  local drawWrapped=setmetatable({},{__mode='k'})
  local function install(game)
    if not R.active() then return end
    R.game=mod.game or game or R.game
    R.inheritPresentation()
    -- Public events remain primary. A hot reload can join an existing battle
    -- after battle.started has already fired; recover the clock exactly once.
    local native=R.module('src.core.game3.battle.init')or R.module('src.core.game3.battle')
    if native and native.isActive and native.isActive()and not R.lighting.active then
      R.lighting.started();R.ambient.started()
    end
    R.battleScreens=R.battleScreens or R.load('gen3/battle_screens.lua')(R);R.battleScreens.installLoaded();R.battleTouch.install(R.game);R.art.installLoaded();R.battle.installLoaded();R.extras.install();R.scenery.installLoaded();R.framing.installLoaded()
    local Game=R.module('src.core.Game3')
    if Game and not drawWrapped[Game] and type(Game.draw)=='function' then
      drawWrapped[Game]=true
      R.wrap(Game,'draw',function(next,self,...)
        -- Menus can be lazy-loaded during the preceding update. Install before
        -- the first actual draw, avoiding an initial frame with the old skin.
        install(self)
        local cameraToken=R.compat.begin()
        local ok,a,b=pcall(next,self,...)
        R.compat.finish(cameraToken)
        if not ok then error(a,0) end
        return a,b
      end)
    end
  end
  local GameOwner=R.module('src.core.Game3')
  local ownerKey='_battle_menu_2d_jo5k_owner'
  local previous=GameOwner and GameOwner[ownerKey]
  if previous and previous.shutdown then previous.shutdown()end
  local owner={}
  if GameOwner then GameOwner[ownerKey]=owner end
  install(mod.game)
  R.on('battle.started',function(e) if R.active() then R.lighting.started(e);R.ambient.started() end end)
  R.on('battle.ended',function() R.lighting.ended();R.ambient.ended() end)
  R.on('battle.move_used',function()R.ambient.trigger()end)
  R.on('game.ready',function() install(mod.game) end)
  R.hook('render.viewport',function(next,ctx)
    local requested=next(ctx)
    if not R.active() or R.unloaded then return requested end
    local result=R.portrait.viewport(requested,ctx)
    if result and result.width and result.height then R.portrait.refresh(result.width,result.height)
    elseif ctx then R.portrait.refresh(ctx.width,ctx.height) end
    return result
  end,250)
  R.hook('input.step',function(next,game,dt)
    install(game)
    if R.active() then R.lighting.update(dt);R.ambient.update(dt);R.battleTouch.update(game,dt) end
    return next(game,dt)
  end,250)
  R.hook('input.pointer',function(next,game,event)
    local ok,handled=pcall(R.battleTouch.pointer,game,event)
    if not ok then R.battleTouch.failed=true;R.warn('battle touch fallback',handled)elseif handled then return true end
    return next(game,event)
  end,250)
  R.hook('render.hud',function(next,game,viewport)
    local out=next(game,viewport)
    install(game)
    if R.unloaded then return out end
    local ok,err=pcall(function()R.battle.draw(game,viewport);R.extras.evolutionHud(viewport.width,viewport.height);R.battleTouch.draw(game,viewport.width,viewport.height)end)
    if not ok then R.battle.failed=true;R.warn('battle renderer disabled; native UI restored',err) end
    return out
  end,250)
  local unloaded=false
  local function unload()
    if unloaded then return end;unloaded=true;R.unloaded=true
    if GameOwner and GameOwner[ownerKey]==owner then GameOwner[ownerKey]=nil end
    for i=#R.subscriptions,1,-1 do
      local ok,err=pcall(R.subscriptions[i]);if not ok then R.warn('subscription cleanup',err)end
    end
    R.subscriptions={}
    R.mode.stop();R.stopSummary();R.extras.shutdown();if R.battleScreens then R.battleScreens.shutdown()end;R.battleTouch.shutdown();R.postLight.shutdown();R.details.shutdown();R.ambient.shutdown();R.lighting.shutdown();R.shadows.shutdown();R.scenery.shutdown();R.portrait.shutdown();if R.battle.shutdown then R.battle.shutdown() end
    for i=#R.patches,1,-1 do
      local p=R.patches[i]
      if p[1][p[2]]==p[4] then p[1][p[2]]=p[3] end
    end
    R.patches={};R.game=nil;R.lighting.battle=nil
  end
  -- mod.unload is not a supported API3 event. Use the official launcher
  -- lifecycle hook, plus an owner lease for explicit shutdown / hot reload.
  R.hook('core.quit_to_launcher',function(next,...)
    local out={pcall(next,...)};unload()
    if not out[1]then error(out[2],0)end
    return (table.unpack or unpack)(out,2)
  end,250)
  if owner then owner.shutdown=unload end
  mod.exports.gen3={version=R.version,engine=R.engine,api=3,stage='Compatibility / pre-release 4',shutdown=unload,
    resetPresentation=function()R.battle.settingsOpen=false;R.battle.lightingSettingsOpen=false;R.battle.drawStamp=nil;R.battleTouch.shutdown();if R.parallax then R.parallax.reset()end;local pad=R.battleTouch.pad(R.game or mod.game);if pad and pad.reset then pad:reset()end end,setBattleMode=R.mode.select,battleMode=R.mode.current,registerType=R.battle.registerType,registerSceneLayer=R.details.register,removeSceneLayer=R.details.remove,diagnostics=function() return {api=3,unloaded=R.unloaded==true,inherited=R.inherited,liveGame=R.game~=nil,liveOptions=R.game and R.game.mods and R.game.mods.modOptions~=nil,capabilities=R.capabilities,warnings=R.warnings,battleFallback=R.battle.failed==true,lighting={active=R.lighting.active,enabled=R.lighting.enabled(),profile=R.lighting.profile,hour=R.lighting.hour,failed=R.lighting.failed,postRays=R.postLight.enabled(),postRaysFailed=R.postLight.failed}} end}
  if mod.log and mod.log.info then
    mod.log:info('2D Battle Menu - Jo5-k %s initialized for %s; native sandbox require bridge active.',R.version,game)
  end
  return R
end
