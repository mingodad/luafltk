-- Declaration of global variables
myLink = myLink or nil
make_window = make_window or nil
html_view = html_view or nil

function myLink(caller, href)
  fl_message(href)
  return nil
end

function make_window()
  local o = Fl_Double_Window:new(631, 122, 432, 289, "DAD")
  do
    local o = Fl_Help_View:new(25, 25, 378, 240)
    html_view = o
    --o:labelsize(18)
    o:value("<html><body><h1>Domingo</h1><a href='#link'>link</a></body></html>")
	o.inUse = true
    --o:link(myLink)
    --o:endd(o)
  end
  --o:endd(o)
  --o:resizable(o)
  return o
end
fl_alert('Hello !')
for _,i in ipairs {make_window()} do i:show() end
Fl:run()
