pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
-- main tab

-- non gameplay stuff
isdebug=1 -- 1 to enable
debug = ""

-- const
pmaxspeed = 3
psize = 4
rotspeed=0.02
paccel, pdecel = 0.05, 0.99
-- world
score, life = 0, 3

-- player position, velocity, angle
px, py = 64, 64
pvx, pvy = 0,0
pangle = 0
paccelangle = 0 

-- player triangle geom
pgeom={
{{0,-1},{-0.9,1}},
{{-0.9,1},{0.9,1}},
{{0.9,1},{0,-1}}
}

-- asteroid table 
-- {x,y,vel_x,vel_y}
roid = {}
roid_max = 10 -- max nb of roid
roid_nb = 0

-- called only once
function _init()
	cls()
end

-- called every time
function _update()
 -- player collision
 			-- kill if hit by asteroid
 			
 -- player event
	if(btn(⬅️)) then turn_left() end
	if(btn(➡️)) then turn_right() end
	if(btn(⬆️)) then accel() end
	if(btnp(❎)) then fire() end
	update_player()

	-- asteroid update
 if(roid_nb < 10) then
 	spawn_asteroid()
 end	
 update_roid()
end

-- called at 30fps
function _draw()
	cls()
	draw_player()
	draw_asteroid()
	draw_text()
end



-->8
--draw stuff

function draw_player()
	--spaceship
	for p in all(pgeom) do
		line(
			(((cos(pangle)*p[1][1])-(sin(pangle))*p[1][2])*psize) + px,
			(((sin(pangle)*p[1][1])+(cos(pangle))*p[1][2])*psize) + py,
			(((cos(pangle)*p[2][1])-(sin(pangle))*p[2][2])*psize) + px,
			(((sin(pangle)*p[2][1])+(cos(pangle))*p[2][2])*psize) + py,
			7
		)
	end
	-- thruster ?
end

function draw_asteroid()
 -- shitty placeholder
 for r in all(roid) do
 	circfill(r[1],r[2],2,8)
 end
end

function draw_text()
	print("score: "..score, 3,5)
	print("life : "..life, 3,11)
	if(isdebug == 1) then
		print(debug, 3,110,8)
 end
 debug = ""
end

-->8
-- gameplay stuff

-- update player vel/rot/pos/...
function update_player()
	-- decelerate
 pvx *= pdecel
 pvy *= pdecel
 -- cap max speed
	if (pvx < -pmaxspeed) then pvx = -pmaxspeed end
	if (pvy < -pmaxspeed) then pvy = -pmaxspeed end
	if (pvx > pmaxspeed) then pvx = pmaxspeed end
	if (pvy > pmaxspeed) then pvy = pmaxspeed end
	-- move
	px += pvx
	py += pvy
	-- infinite screen
	if(px>127) then px -= 127 end
	if(py>128) then py -= 127 end
	if(px<0) then px += 127 end
	if(py<0) then py += 127 end	
end


function turn_left()
	debug="left "..pangle
	pangle += rotspeed
end

function turn_right()
	debug="right "..pangle
	pangle-= rotspeed
end

function accel()
 paccelangle = pangle
 pvx = pvx + paccel * cos(paccelangle+0.25)
 pvy = pvy + paccel * sin(paccelangle+0.25) 
 debug="accel "..pvx.."/"..pvy
 sfx(1)
end

function fire()
 debug="fire"
 sfx(0)
end

function spawn_asteroid()
	local x = rnd(110) + 10
	local y = rnd(110) + 10
	while((abs(x-px) < 30) and (abs(y-py) < 30)) do
		x = rnd(110) + 10
		y = rnd(110) + 10
	end
	add(roid, {x,y,rnd(2)-1,rnd(2)-1})
	roid_nb += 1
end

function update_roid()
	for r in all(roid) do
		r[1] += r[3]
		r[2] += r[4]
			-- infinite screen
		if(r[1]>127) then r[1] -= 127 end
		if(r[2]>128) then r[2] -= 127 end
		if(r[1]<0) then r[1] += 127 end
		if(r[2]<0) then r[2] += 127 end	

	end
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00010000310502a05025050153500c3500a35003350013500030008300043000130000300003000030000300090000c0000000000000000000000000000000000000000000000000000000000000000000000000
001000001c61000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
