
--[[ This version is terribly slow. Fl:event_inside couldn't use the widget name directly,
     because the nested widget window adds 20 pixels the the visual y position that is not
     accounted for by event_inside. The widget is never where FLTK thinks it is.
function drag_loop()
  if Fl:event() == fltk.FL_DRAG and Fl:event_inside(drag_box:x()-20,drag_box:y()-20+demo_bh,72,72) ~= 0 then
    drag_box:position(Fl:event_x()-16,Fl:event_y()-16-demo_bh)
    demo_widget:redraw()
  end
  drag_timer:doWait(.002)
end
]]

-- This version is must faster, but with limited behavior
function drag_loop()
  if fltk.Fl:event() == fltk.FL_DRAG then
    drag_box:position(fltk.Fl:event_x()-16,fltk.Fl:event_y()-16-demo_bh)
    demo_widget:redraw()
  end
  drag_timer:doWait(.02)
end

drag_box=fltk.Fl_Box:new(40,40,32,32)
drag_box:box(fltk.FL_THIN_UP_BOX)

drag_timer = murgaLua.createFltkTimer()
drag_timer:callback(drag_loop)
drag_timer:do_callback()
