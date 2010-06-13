-- counter widget

counter_widget = fltk.Fl_Counter:new(10,10,200,30,"FL_NORMAL_COUNTER")
counter_widget:align(fltk.FL_ALIGN_BOTTOM)
counter_widget:lstep(5) -- step of double arrows (default is 1.0)
counter_widget2 = fltk.Fl_Counter:new(10,100,200,30,"FL_SIMPLE_COUNTER")
counter_widget2:type(fltk.FL_SIMPLE_COUNTER)
counter_widget_output = fltk.Fl_Value_Output:new(10,60,200,30)

function counter_widget_cb(self)
counter_widget_output:value(self:value())
end

counter_widget:callback(counter_widget_cb)
counter_widget2:callback(counter_widget_cb)

