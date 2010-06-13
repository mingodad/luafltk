--x1,y1,x2,y2=0,0,0,0

--print(fltk.FL_PUSH)

function draw_lines()
--	print(Fl:event())
  -- do it only if your clicking within the display box
  -- event_inside aparently uses top window coodinates, so "demo_bh" was
  -- used for x position instead of 0. Using the wiget name is no better.
  if fltk.Fl:event() == fltk.FL_DRAG and fltk.Fl:event_inside(0,demo_bh,500,400) == 1 then
    demo_widget:make_current() -- needed for all drawing functions
    fltk.fl_color(fltk.FL_BLACK)
    fltk.fl_font(fltk.FL_HELVETICA_BOLD,20)
    if not x1 and not x2 then x1,y1=fltk.Fl:event_x(),fltk.Fl:event_y()-demo_bh else
      x2,y2=fltk.Fl:event_x(),fltk.Fl:event_y()-demo_bh
      fltk.fl_line(x1,y1,x2,y2)
      x1,y1=x2,y2
    end
  else
    x1,y1,x2,y2=nil,nil,nil,nil
  end
end

function draw_loop(data)
  draw_lines()
  fltk.Fl:check()
  timer:doWait(0.001)
end

-- a white box over which to draw
lines_display=fltk.Fl_Box:new(0,0,500,400)
lines_display:color(fltk.FL_WHITE)
lines_display:box(fltk.FL_FLAT_BOX)

timer = murgaLua.createFltkTimer()
timer:callback(draw_loop)
timer:do_callback()
