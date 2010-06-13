
demo_widget:color(0)
balls=250
bsize=10

function grav_loop()
if not balls then return end
local my_x,bx=fltk.Fl:event_x(),0
local my_y,by=fltk.Fl:event_y()-demo_bh,0
local c=math.random(1,255)
local b=math.random(1,balls)
ball[b]:color(c)
  for i=1,balls do
    if my_x > ball[i]:x() then
      bx=ball[i]:x()+max_x/(my_x-ball[i]:x())
    else
      bx=ball[i]:x()+max_x/(my_x-ball[i]:x())
    end
    if my_y > ball[i]:y() then
      by=ball[i]:y()+max_y/(my_y-ball[i]:y())
    else
      by=ball[i]:y()+max_y/(my_y-ball[i]:y())
    end
    ball[i]:position(bx,by)
  end
demo_widget:redraw()
grav_timer:doWait(.05)
end

fltk.fl_define_FL_RFLAT_BOX()
math.randomseed(os.time())
max_x=demo_widget:w()-bsize
max_y=demo_widget:h()-bsize
ball={}
for i=1,balls do
ball[i]=fltk.Fl_Box:new(math.random(1,max_x),math.random(1,max_y),bsize,bsize)
if fltk._FL_RFLAT_BOX then ball[i]:box(fltk._FL_RFLAT_BOX) else ball[i]:box(fltk.FL_RFLAT_BOX) end
end

grav_timer = murgaLua.createFltkTimer()
grav_timer:callback(grav_loop)
grav_timer:do_callback()
