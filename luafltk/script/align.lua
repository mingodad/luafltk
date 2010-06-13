
albox=fltk.Fl_Box:new(120,100,200,120,
[[When you set an image to a widget,
it becomes a part of the widget's label and will be affected by align()

lalalalalalalalalalalalalalalalalalalalalalalalalongstringofnonbreakingtextlalalalalalala
]])
albox:box(fltk.FL_BORDER_BOX)
albox:image(fltk.Fl_XPM_Image(demo_images.."eyes.xpm"))

ukslide = fltk.Fl_Value_Slider:new(20,300,400,30)
ukslide:type(fltk.FL_HORIZONTAL)
ukslide:align(fltk.FL_ALIGN_TOP)
ukslide:step(1)
ukslide:minimum(0)
ukslide:maximum(255)
ukslide:callback(
function(ukslide_cb)
  albox:hide()
  albox:align(ukslide:value())
  albox:show()
end
)

fltk.Fl:focus(ukslide)
