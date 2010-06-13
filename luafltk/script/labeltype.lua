
if not fltk.FL_SHADOW_LABEL then
sorry=fltk.Fl_Box:new(10,10,0,0,"This example requires murgaLua version 0.6 or later")
sorry:align(fltk.FL_ALIGN_RIGHT)
else

function show_label(self)
lout:value(self:label())
end

-- label types must be defined before they are used
fltk.fl_define_FL_SHADOW_LABEL()
fltk.fl_define_FL_EMBOSSED_LABEL()
fltk.fl_define_FL_ENGRAVED_LABEL()

lbutts={}
lbutts[0]=fltk.Fl_Button:new(10,10,340,30,"FL_NORMAL_LABEL ("..fltk.FL_NORMAL_LABEL..")")
lbutts[1]=fltk.Fl_Button:new(10,40,340,30,"FL_NO_LABEL ("..fltk.FL_NO_LABEL..")")
lbutts[2]=fltk.Fl_Button:new(10,70,340,30,"FL_SHADOW_LABEL ("..fltk.FL_SHADOW_LABEL..")")
lbutts[3]=fltk.Fl_Button:new(10,100,340,30,"FL_ENGRAVED_LABEL ("..fltk.FL_ENGRAVED_LABEL..")")
lbutts[4]=fltk.Fl_Button:new(10,130,340,30,"FL_EMBOSSED_LABEL ("..fltk.FL_EMBOSSED_LABEL..")")
--[[ these are unsupported, or I just don't know how to use them
lbutts[5]=fltk.Fl_Button(10,160,340,30,"FL_MULTI_LABEL ("..fltk.FL_MULTI_LABEL..")")
lbutts[6]=fltk.Fl_Button(10,190,340,30,"FL_ICON_LABEL ("..fltk.FL_ICON_LABEL..")")
lbutts[7]=fltk.Fl_Button(10,220,340,30,"FL_IMAGE_LABEL ("..fltk.FL_IMAGE_LABEL..")")
lbutts[8]=fltk.Fl_Button(10,250,340,30,"FL_FREE_LABELTYPE ("..fltk.FL_FREE_LABELTYPE..")")
]]

for i = 0,4 do
lbutts[i]:callback(show_label)
lbutts[i]:labeltype(i)
--lbutts[i]:redraw()
end

--lout=fltk.Fl_Output(10,280,340,30)
lout=fltk.Fl_Output:new(10,190,340,30)

end
