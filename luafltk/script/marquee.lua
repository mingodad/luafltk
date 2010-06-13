

function scroll_label_text()
  -- cut off the first character and stick it at the end
  local l,r=string.gsub(marquee:label(),"^(.)(.*)$","%2%1")
  marquee:hide()
  marquee:label(l)
  marquee:show()
  fltk.Fl:check()
  timer:doWait(0.15)
end

marquee=fltk.Fl_Box:new(10,10,200,30)
marquee:box(fltk.FL_THIN_DOWN_BOX)
marquee:label("* This is a test of the eMurgacy broadcasting system *")
marquee:align(fltk.FL_ALIGN_CLIP) -- keep the text from bleeding
--marquee:labelfont(fltk.FL_COURIER) -- monospace font makes smoother scroll
marquee:labelfont(fltk.FL_SCREEN) -- monospace font makes smoother scroll

timer=murgaLua.createFltkTimer()
timer:callback(scroll_label_text)
timer:do_callback()
