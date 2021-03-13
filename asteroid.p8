pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
isdebug=1
px, py = 64, 64
pvx, pvy = 0,0
paccel= 0.05
pdecel = 0.02
pangle = 0.0
pgeom={
{{0,-1},{-1,1}},
{{-1,1},{1,1}},
{{1,1},{0,-1}}
}
psize = 4
score, life = 0, 3
debug = ""
rotspeed=0.02

function _init()
	cls()
end

function _update()
	cls()
 -- player collision
 			-- kill if hit by asteroid
 			
 -- player event
	if(btn(⬅️)) then turn_left() end
	if(btn(➡️)) then turn_right() end
	if(btn(⬆️)) then accel() end
	if(btn(❎)) then fire() end
	update_player()
end

function _draw()
	draw_player()
	draw_text()
end

function draw_player()
	--hitbox
	rect(px-psize,py-psize,
					 px+psize,py+psize,2)
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
end

function update_player()
	pvx -= pdecel
	pvy -= pdecel
	if (pvx < 0) then pvx = 0 end
	if (pvy < 0) then pvy = 0 end
 px += pvx
 py += pvy
end

function draw_text()
	print("score: "..score, 3,5)
	print("life : "..life, 3,11)
	if(isdebug == 1) then
		print("debug: "..debug, 3,110,8)
 end
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
 pvx += paccel
 pvy += paccel
 debug="accel "..pvx.."/"..pvy
end

function fire()
 debug="fire"
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
