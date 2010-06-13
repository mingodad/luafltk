
function tooltipsy()
fltk.Fl_Tooltip:font(ttfont_s:value())
fltk.Fl_Tooltip:size(ttsize_s:value())
fltk.Fl_Tooltip:color(ttcolor_b:color())
fltk.Fl_Tooltip:textcolor(ttcolor_b:labelcolor())
fltk.Fl_Tooltip:delay(ttdelay_s:value())
fltk.Fl_Tooltip:hoverdelay(tthdelay_s:value())
if tt_text:value() ~= "" then hoverbox:tooltip(tt_text:value()) end
end

function tt_colorchange(self)
  local newcolor=fltk.fl_show_colormap(self:color())
  if newcolor then
    if self==tttcolor_b then
      ttcolor_b:labelcolor(newcolor)
      tttcolor_b:labelcolor(newcolor)
    else
      ttcolor_b:color(newcolor)
      tttcolor_b:color(newcolor)
    end
    ttcolor_b:redraw()
    tttcolor_b:redraw()
  end
end

hoverbox=fltk.Fl_Box:new(20,20,180,100,"Hover over me to see the tooltip magically appear")
hoverbox:box(fltk.FL_DOWN_BOX)
hoverbox:align(fltk.FL_ALIGN_WRAP)
hoverbox:tooltip("can you see me now?")

hoverbox2=fltk.Fl_Box:new(20,120,180,100,"hoverdelay sets the tooltip delay when switching widgets")
hoverbox2:box(fltk.FL_DOWN_BOX)
hoverbox2:align(fltk.FL_ALIGN_WRAP)
hoverbox2:tooltip("another tooltip")

tooltipbutton=fltk.Fl_Button:new(200,20,180,30,"apply changes")
tooltipbutton:callback(tooltipsy)
tooltipbutton:tooltip("click to apply changes")

ttcolor_b=fltk.Fl_Button:new(200,50,90,30,"color")
ttcolor_b:color(fltk.Fl_Tooltip:color())
ttcolor_b:labelcolor(fltk.Fl_Tooltip:textcolor())
ttcolor_b:callback(tt_colorchange)
tttcolor_b=fltk.Fl_Button:new(290,50,90,30,"text color")
tttcolor_b:color(fltk.Fl_Tooltip:color())
tttcolor_b:labelcolor(fltk.Fl_Tooltip:textcolor())
tttcolor_b:callback(tt_colorchange)

ttfont_s=fltk.Fl_Hor_Value_Slider:new(200,80,180,20,"font")
ttfont_s:range(0,15)
ttfont_s:value(fltk.Fl_Tooltip:font())
ttfont_s:step(1) -- forces integers
ttfont_s:align(8)

ttsize_s=fltk.Fl_Hor_Value_Slider:new(200,100,180,20,"size")
ttsize_s:range(8,24)
ttsize_s:value(fltk.Fl_Tooltip:size())
ttsize_s:step(1)
ttsize_s:align(8)

ttdelay_s=fltk.Fl_Hor_Value_Slider:new(200,120,180,20,"delay")
ttdelay_s:range(0,5)
ttdelay_s:value(fltk.Fl_Tooltip:delay())
ttdelay_s:align(8)

tthdelay_s=fltk.Fl_Hor_Value_Slider:new(200,140,180,20,"hoverdelay")
tthdelay_s:range(0,5)
tthdelay_s:value(fltk.Fl_Tooltip:hoverdelay())
tthdelay_s:align(8)

tt_text=fltk.Fl_Multiline_Input:new(200,160,180,60,"tooltip\ntext")
tt_text:align(8)
