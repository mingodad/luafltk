
posy=fltk.Fl_Positioner:new(10,10,300,200,"fltk.Fl_Positioner")

posy_xvalue=fltk.Fl_Value_Output:new(40,240,50,20,"x:")
posy_yvalue=fltk.Fl_Value_Output:new(140,240,50,20,"y:")

posy:xstep(1)
posy:ystep(1)
posy:xbounds(0,300)
posy:ybounds(0,200)

posy:callback(
function()
  posy_xvalue:value(posy:xvalue())
  posy_yvalue:value(posy:yvalue())
end
)
