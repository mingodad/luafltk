-- adjuster widget

adj_output = fltk.Fl_Value_Output:new(50,10,60,30,"@<-  Fl_Value_Output")
adj_output:align(fltk.FL_ALIGN_RIGHT)

adj = fltk.Fl_Adjuster:new(50,45,200,30,"Fl_Adjuster")
adj:selection_color(fltk.FL_RED) -- color of arrows
adj:align(fltk.FL_ALIGN_BOTTOM) -- position of text label
adj:callback(function(adj_cb)
adj_output:value(adj:value())
end
)

fltk.Fl:focus(adj)

--print(adj.bind_lua_typeinfo.name)
