-- Game

function init_game()
 init_sprites()
end

-- Sprites

function init_sprites()
 sprites={}
end

function draw_sprites()
 for i=1,#sprites do
  local s=sprites[i]
  
  spr(
   anim_frame(sprite_anim(s)),
   s.x,s.y,
   1,1,
   s.flip
  )
 end
end

function build_sprite()
 return {
  x=0,y=0,
  dx=0,dy=0,
  anims={},
  state=1,
  flip=false
 }
end

function add_sprite(s)
 add(sprites,s)
end

function update_sprites()
 for s=1,#sprites do
  sprite_update(sprites[s])
 end
end

function sprite_update(s)
 anim_update(sprite_anim(s))
end

function sprite_anim(s)
 return s.anims[s.state]
end

function sprite_set_state(sp,st)
 if (sp.state==st) then
  return
 end
 
 reset_anim(sprite_anim(sp))
 sp.state=st
end

-- Animations

function build_anim()
 return {
  t=1,
  v=0.125,
  frames={},
  frame=1
 }
end

function anim_update(anim)
 anim.t=max(anim.t-anim.v,0)
 if anim.t==0 then
  anim.frame+=1
  if anim.frame>#anim.frames then
   anim.frame=1
  end
  anim.t=1
 end
end

function anim_add_frame(anim,si)
 add(anim.frames,si)
end

function anim_frame(anim)
 return anim.frames[anim.frame]
end

function reset_anim(anim)
 anim.frame=1
 anim.t=1
end

-- Map

function tile_at(x,y)
 return mget(x/8,y/8)
end

function flag_at(x,y)
 fget(tile_at(x,y))
end
