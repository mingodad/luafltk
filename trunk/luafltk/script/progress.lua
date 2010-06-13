
progbar=fltk.Fl_Progress:new(20,30,300,30)
progbar:minimum(0)
progbar:maximum(100)

progbar:value(demo_progress)

if demo_progress==100 then progbar:selection_color(fltk.FL_GREEN) end
progbar:label(demo_progress.."% ("..table.getn(demo_widgets_seen).." of "..demo_num_widgets..")")
