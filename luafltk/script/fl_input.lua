-- fl_input (function)
-- fltk.fl_intput(prompt_text,initial_input_text)

fl_input_output=fltk.Fl_Output:new(10,40,350,30)
fl_input_button=fltk.Fl_Return_Button:new(10,10,200,30,"fltk.fl_input")
fl_input_button:callback(function(fc_cb)
 local inpoot=fltk.fl_input("input...",fl_input_output:value())
 if inpoot then fl_input_output:value(inpoot) end
end
)
