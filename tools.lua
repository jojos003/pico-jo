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

function build_sprite(x,y,w,h)
 local s={}

 s.x=x or 0
 s.y=y or 0
 s.dx=s.x
 s.dy=s.dy

 s.w=w or 8
 s.h=h or 8

 s.vx=0
 s.vy=0

 s.anims={}
 s.state=1
 s.flip=false

 return s
end

function add_sprite(s)
 add(sprites,s)
end

function remove_sprite(s)
 del(sprites,s)
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

function sprites_collide(sp1,sp2)
 return collide(sp1.x,sp1.y,sp1.w,sp1.h,
   sp2.x,sp2.y,sp2.w,sp2.h)
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

-- utils

function collide(x1,y1,w1,h1,x2,y2,w2,h2)
 return x1 < x2+w2
 and x1+w1 > x2
 and y1 < y2+h2
 and y1+h1 > y2
end
