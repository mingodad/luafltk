
pnm_img=fltk.Fl_PNM_Image(demo_images.."eyeball.ppm")
pnm_box=fltk.Fl_Box:new(30,20,100,100)
pnm_box:box(fltk.FL_THIN_UP_BOX)
pnm_box:image(pnm_img)
pnm_box:tooltip("my_image:count() = "..pnm_img:count())
pnm_label=fltk.Fl_Box:new(30,120,100,30,"fltk.Fl_PNM_Image(filename)")
pnm_label:align(20) --inside, left
