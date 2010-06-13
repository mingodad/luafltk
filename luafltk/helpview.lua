-- Declaration of global variables
myLink = myLink or nil
make_window = make_window or nil
html_view = html_view or nil

function myLink(caller, href)
  fltk.fl_message(href)
  return nil
end

function make_window()
  local o = fltk.Fl_Double_Window->new(631, 122, 432, 320, 'DAD')
  do
    local o = fltk.Fl_Help_View->new(25, 25, 378, 240)
    html_view = o
    o->labelsize(18)
	print(o->labelsize())
    o->value("<html><body><h1>Domingo</h1><a href='#link'>link</a></body></html>")
    o->link(myLink)
    o->endd()
	local o = fltk.Fl_Button->new(25, 270, 60, 30, 'Ok !')
	o->callback(function(w) fltk.fl_alert('Hello !') end)
  end
  o->endd()
  o:resizable(o)
  btn = fltk.Fl_Button->new(25, 270, 60, 30, 'Ok !')
  btn->delete()
  return o
end

for _,i in ipairs {make_window()} do i->show() end

myTimeoutRef = 0
x = 0
function myTimeout(param)
	print('Timeout :', myTimeoutRef, param, x)
	x = x +1;
	fltk.Fl->repeat_timeout(1, myTimeoutRef)
end

myTimeoutRef = fltk.Fl->add_timeout(1, myTimeout)

myIdleRef = 0
ix = 0
function myIdle(param)
	print('Idle :', myIdleRef, param, ix)
	ix = ix +1;
	if ix > 1000 then
		fltk.Fl->remove_idle(myIdleRef)
	end
end

myIdleRef2 = 0
ix2 = 0
function myIdle2(param)
	print('Idle2 :', myIdleRef2, param, ix2)
	ix2 = ix2 +1;
	if ix2 > 1000 then
		fltk.Fl->remove_idle(myIdleRef2)
	end
end

myIdleRef = fltk.Fl->add_idle(myIdle, myLink)
myIdleRef2 = fltk.Fl->add_idle(myIdle2, myLink)

fltk.Fl->add_timeout(10, function(par) print(myIdleRef); fltk.Fl->remove_idle(myIdleRef) end)

fltk.Fl->add_timeout(15, function(par) print(myIdleRef2); fltk.Fl->remove_idle(myIdleRef) end)

fltk.Fl->run()
