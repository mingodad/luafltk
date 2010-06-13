
balls=500 -- number of dots
bsize=2    -- dot size
max_grav=5 -- maximum gravity
hole=20    -- distance from cursor within which dots warp
demo_widget:color(0)

function grav_loop()
if not balls then return end
-- normally the cursor would be set once after the target window is shown, but
-- the widgets demo loads and runs this script before the widget window is shown.
demo_widget:cursor(66) -- cross
local my_x,my_y=fltk.Fl:event_x(),fltk.Fl:event_y()-demo_bh -- cursor location
local xspeed,yspeed,bx,by -- initialize some local vars
local c=math.random(1,255) -- random color (except black)
  for i=1,balls do
    -- find distance of dots from the cursor
    local xdistance=math.abs(my_x-ball[i]:x()) -- horz distance from cursor
    local ydistance=math.abs(my_y-ball[i]:y()) -- vert distance
    local distance=math.sqrt(xdistance^2+ydistance^2) -- as the crow flies
    if distance <= hole then
      ball[i]:color(c) -- set the color of the dot about to be warped
      -- These equations have no defined mathematical logic behind them.
      -- I was just playing with numbers until something cool happened.
      -- xspeed and yspeed are actually distance measurements (how far to move the dot in one loop)
      -- random offset prevents the dots from eventually converging on a single x-y intersection
      xspeed=xdistance*demo_widget:w()/distance/1.5+math.random(-100,100)
      yspeed=ydistance*demo_widget:h()/distance/1.5+math.random(-100,100)
    else
      -- thanks to Juergen for help with this
      xspeed=max_grav/distance*xdistance
      yspeed=max_grav/distance*ydistance
    end 
    -- move the dot according to its relative position to cursor
    if my_x > ball[i]:x() then bx=ball[i]:x()+xspeed else bx=ball[i]:x()-xspeed end
    if my_y > ball[i]:y() then by=ball[i]:y()+yspeed else by=ball[i]:y()-yspeed end
    ball[i]:position(bx,by)
  end
demo_widget:redraw()
grav_timer:doWait(.05)
end


math.randomseed(os.time()) -- set a seed for upcoming math.random()
-- set up dots in random locations
ball={}
for i=1,balls do
ball[i]=fltk.Fl_Box:new(math.random(1,demo_widget:w()),math.random(1,demo_widget:h()),bsize,bsize)
ball[i]:box(fltk.FL_FLAT_BOX)
end

grav_timer = murgaLua.createFltkTimer()
grav_timer:callback(grav_loop)
grav_timer:do_callback()

