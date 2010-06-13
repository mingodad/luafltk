-- choice widget

choices = {"Ham Sandwich","Green","14.2","MOVE 'ZIG'.","FOR GREAT JUSTICE."}
choice_output = fltk.Fl_Output:new(10,10,300,30)
choice_list = fltk.Fl_Choice:new(10,40,300,30)

--print(choice_list:value(), choice_list:size())
for i = 1,table.getn(choices) do
  choice_list:add(choices[i])
end
--print(choice_list:value(), choice_list:size())
choice_list:value(0)

choice_list:callback(
function(choice_cb)
choice_output:value("value: "..choice_list:value()..", text: "..choice_list:text())
end
)
