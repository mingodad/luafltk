xpm_box=fltk.Fl_Box:new(30,30,300,236)
xpm_box_label=fltk.Fl_Box:new(30,0,300,30)
xpm_box_label:label("my_widget:image(fltk.Fl_XPM_Image(filename))")

xpm_file=demo_images.."xpm_image.xpm"

xpm_data=fltk.Fl_XPM_Image(xpm_file)
xpm_box:image(xpm_data)
xpm_box:tooltip("my_image:count() = "..xpm_data:count())
 
desaturate=fltk.Fl_Button:new(30,266,300,30,"desaturate")
desaturate:callback(function(desat_cb)
xpm_data:desaturate()
xpm_box:redraw_label()
end
)
inactive=fltk.Fl_Button:new(30,296,300,30,"inactive")
inactive:callback(function(inact_cb)
xpm_data:inactive()
xpm_box:redraw_label()
end
)
reset=fltk.Fl_Button:new(30,326,300,30,"reset")
reset:callback(function(reset_cb)
xpm_data:uncache()
xpm_data=fltk.Fl_XPM_Image(xpm_file)
xpm_box:image(xpm_data)
xpm_box:redraw_label()
end
)

color_button=fltk.Fl_Button:new(330,326,30,30,"@<-  color_average()")
color_button:align(fltk.FL_ALIGN_RIGHT)
color_button:color(fltk.FL_RED)
color_button:callback(function(cb_cb)
local newcolor=fltk.fl_show_colormap(color_button:color())
color_button:color(newcolor)
color_slider:do_callback()
end
)
color_slider=fltk.Fl_Value_Slider:new(330,30,30,296)
color_slider:minimum(0)
color_slider:maximum(1)
color_slider:step(0.1)
color_slider:value(1)
color_slider:callback(function(cscb)
reset:do_callback()
xpm_data:color_average(color_button:color(),color_slider:value())
xpm_box:redraw_label()
end
)
