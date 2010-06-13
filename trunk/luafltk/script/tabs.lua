
function show2()
if on2:takesevents() == 1 then
on2:hide()
tab2:deactivate()
on1:label("unlock tab2")
else
tab2:activate()
on2:show()
on1:label("lock tab2")
end
end

tabs=fltk.Fl_Tabs:new(10,20,300,215,"Tabs")

tab1 = fltk.Fl_Group:new(10,40,300,195,"Tab1")
on1=fltk.Fl_Button:new(20,60,100,30,"unlock tab 2");on1:callback(show2)
fltk.Fl_End() --end of tab1 group
tab2 = fltk.Fl_Group:new(10,40,300,195,"Tab2")
on2=fltk.Fl_Box:new(20,60,280,155);on2:box(fltk.FL_THIN_DOWN_BOX)
on2:label("Congratulations!\nYou pressed a button!")
fltk.Fl_End()

tab2:deactivate()
on2:hide()
