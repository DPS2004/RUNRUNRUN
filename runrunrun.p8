pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

function _init()
	--here are the coords for the player. the x remains the same.
	--format is y1,y2 for first 8, last number is y offset
	fx = {0,4,3,3,3,0,0,0}
	--still
	f0y = {0,0,0,5,3,3,5,0,5}
	--walk1
	f1y = {0,0,0,4,3,3,5,0,5}
	--walk2
	f2y = {0,0,0,5,3,3,4,0,5}
	--jump1
	f3y = {0,0,0,6,4,4,6,0,6}
	--jump2
	f4y = {0,0,0,5,4,4,5,0,5}
	--squish
	f5y = {0,0,0,3,2,2,3,0,3}
	player = {x=30,y=94, sprlst = f0y, state = "title"}
	a = 0
	blockx = {0,50,60,90}
	blocky = {95, 115}
	textkern = {7,9,7,9,7,7,7,9,6,7,9,9,9,9,6,6}
	ta = 0
end
function drawplayer(xpos,ypos,xscale,yscale,frx,fry)
	for i=0,7,2 do
		line(frx[i+1] * xscale + xpos,fry[i+1] * yscale + ypos - (fry[9]*yscale),frx[i+2] * xscale +xpos,fry[i+2] * yscale + ypos - (fry[9] * yscale),8)
		
	end
end

function drawtext(txt, offset)
	ta += 0.05
	textx = 0
	sinoffset = 0
	for i in all(txt) do
		spr(i,textx + offset,sin(ta + sinoffset) * 4 + 8)
		textx += textkern[i]
		sinoffset += 0.06	
	end
end


i = 0
function _update()
	i += 1
end

function _draw()
	-- handle animations.
	if player.state == "run" then
		a += 1
		if a == 4 then
			if player.sprlst == f1y then
				player.sprlst = f2y
			else
				player.sprlst = f1y
			end
			a = 0
		end
	end
	if player.state == "jump" then
		if player.sprlst == f1y or player.sprlst == f2y then
			player.sprlst = f3y
		elseif player.sprlst == f3y then
			player.sprlst = f4y
		end
	end
	if player.state == "title" then
		player.sprlst = f0y
	end
		
	if player.state == "land" then
		player.sprlst = f5y
		player.state = "run"
	end
	cls(1)
	drawplayer(player.x,player.y,1,1,fx,player.sprlst)
	-- draw platforms
	for i=1,#blocky do
		rect(blockx[i*2-1],blocky[i],blockx[i*2],128) 
	end
	drawtext({6,7,8,6,7,8,6,7,8},32)
end
__gfx__
00000000888888800008800008888800888888888888880088880000880088008800008888880000888888000888880088000088088888808800008888000000
00000000888888800088880088888800888888888888880088888000880088008880008888888000888888008888880088800888888888888800008888000000
00000000880000000888888088000000000880008800000088088000880088008888008888088000008800008880000088888888880000888800008888000000
00000000888880008880088888888000000880008888800088888000880088008888808888888000008800008800888088888888880000888800008888000000
00000000888880008800008808888800000880008888800088888800880088008808888888888000008800008800888888088088880000880880088088000000
00000000880000008888888800008800000880008800000088008800880088008800888888088000008800008800008888088088880000880888888088000000
00000000880000008888888888888800000880008888880088008800888888008800088888888000888888008888888888088088888888880088880088888000
00000000880000008800008888888000000880008888880088008800088880008800008888880000888888000888888088088088088888800008800088888000
