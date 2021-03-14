pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
-- particle
-- 1: position - x,y
-- 2: velolicty - x,y
-- 3: acceleration - x,y
-- 4: lifespan
-- 5: increment use for the lifespan
function new_particle(position, size, incr) 
 local particle = {
  {54+rnd(20),54+rnd(20)},
  {(rnd(100) - 50)/100,(rnd(100)-50)/100},
  {0.01-(rnd(100)/100),0.01-(rnd(100)/100)},
  rnd(40),
  incr
 }

 return particle
end

function part_update(part)
--	part[2][1] = part[2][1] + part[3][1]
--	part[2][2] = part[2][2] + part[3][2]
	part[1][1] = part[1][1] + part[2][1]
	part[1][2] = part[1][2] + part[2][2]
 part[4] -= part[5]
 if(part[1][1] > 127) then 
 	part[1][1] -= 127
 end
 if(part[1][2] > 127) then 
 	part[1][2] -= 127
 end
 if(part[1][1] < 0) then 
 	part[1][1] += 127
 end
 if(part[1][2] < 0) then 
 	part[1][2] += 127
 end
 
end


function part_draw(part)
 pset(part[1][1],part[1][2],6)
end


function part_dead(part)
 return part[4] <= 0
end

-- particles system
-- 1: position - vec2
-- 2: size - int
function new_ps(position, size)
	ps = {
	 position,
	 size,
	 {}
	}
 ps_update(ps)
 return ps
end

function ps_update(ps)
  for i = 1,ps[2] + 1,1
  do
   if(is_empty(ps[3][i]) or part_dead(ps[3][i])) then
    ps[3][i] = new_particle(ps[1],6,0.4)
   end
  part_update(ps[3][i])
  end
end

function ps_draw(ps)
    for i = 1,ps[2] + 1,1
    do
     part_draw(ps[3][i])
    end
end


-- helpers
function is_empty(t)
    for _,_ in pairs(t) do
        return false
    end
    return true
end

-- game loop
local ps = {}
function _init()
 ps = new_ps({61,61},1000)
end

function _draw()
	cls()
    ps_draw(ps)
    print("mem:"..stat(0).."kb",10,10,8)
--    print("fps:"..stat(7),10,16,8)
end

function _update()
    ps_update(ps)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
