
png_img=fltk.Fl_PNG_Image(demo_images.."fish1.png")
png_box=fltk.Fl_Box:new(30,20,100,100)
png_box:box(fltk.FL_THIN_UP_BOX)
png_box:image(png_img)
png_box:tooltip("my_image:count() = "..png_img:count())
png_label=fltk.Fl_Box:new(30,120,100,30,"fltk.Fl_PNG_Image(filename)")
png_label:align(20) --inside, left

