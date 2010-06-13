

function grav_loop()
if not balls then return end
local my_x,bx=fltk.Fl:event_x(),0
local my_y,by=fltk.Fl:event_y()-demo_bh,0
  for i=1,100 do
    if my_x > balls[i]:x() then bx=balls[i]:x()+1 else bx=balls[i]:x()-1 end
    if my_y > balls[i]:y() then by=balls[i]:y()+1 else by=balls[i]:y()-1 end
    balls[i]:position(bx,by)
  end
  demo_widget:redraw()
  grav_timer:doWait(.05)
end

fltk.fl_define_FL_OVAL_BOX()
math.randomseed(os.time())
max_x=demo_widget:w()-10
max_y=demo_widget:h()-10
balls={}
for i=1,100 do
balls[i]=fltk.Fl_Box:new(math.random(1,max_x),math.random(1,max_y),10,10)
if fltk._FL_OVAL_BOX then balls[i]:box(fltk._FL_OVAL_BOX) else balls[i]:box(fltk.FL_OVAL_BOX) end
end

grav_timer = murgaLua.createFltkTimer()
grav_timer:callback(grav_loop)
grav_timer:do_callback()
