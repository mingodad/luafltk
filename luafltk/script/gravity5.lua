
balls=500
bsize=2
min_grav=0
max_grav=6
demo_widget:color(0)

function grav_loop()
if not balls then return end
local my_x,bx,xspeed=fltk.Fl:event_x(),0,0
local my_y,by,yspeed=fltk.Fl:event_y()-demo_bh,0,0
local c=math.random(1,255) -- a random color
  for i=1,balls do
    local xdistance=math.abs(my_x-ball[i]:x())
    local ydistance=math.abs(my_y-ball[i]:y())
    local distance=math.sqrt(xdistance*xdistance+ydistance*ydistance)
    if distance <= 25 then -- warp it offscreen
      ball[i]:color(c)
      xspeed=xspeed*max_x/distance*math.random(2,2.5)
      yspeed=yspeed*max_y/distance*math.random(2,2.5)
      if ball[i]:x() > max_x/2 then bx=ball[i]:x()-xspeed else bx=ball[i]:x()+xspeed end
      if ball[i]:y() > max_y/2 then by=ball[i]:y()-yspeed else by=ball[i]:y()+yspeed end
      ball[i]:position(bx,by)
    else 
      xspeed=(min_grav+max_grav)/distance*xdistance
      yspeed=(min_grav+max_grav)/distance*ydistance
      if my_x > ball[i]:x() then bx=ball[i]:x()+xspeed else bx=ball[i]:x()-xspeed end
      if my_y > ball[i]:y() then by=ball[i]:y()+yspeed else by=ball[i]:y()-yspeed end
      ball[i]:position(bx,by)
    end
  end
demo_widget:redraw()
grav_timer:doWait(.05)
end

math.randomseed(os.time())
max_x=demo_widget:w()-bsize
max_y=demo_widget:h()-bsize
ball={}
for i=1,balls do
ball[i]=fltk.Fl_Box:new(math.random(1,max_x),math.random(1,max_y),bsize,bsize)
ball[i]:box(fltk.FL_FLAT_BOX)
end

grav_timer = murgaLua.createFltkTimer()
grav_timer:callback(grav_loop)
grav_timer:do_callback()
