
--
-- Simple calculator by dvw86
--
-- Taken from : http://www.murga-projects.com/forum/showthread.php?tid=14
--

-- Define the total
total = "0"

-- Define the memory
memory = "0"

-- Define the erase status
erase = true

-- Define the text buffer
buffer = "0"

-- Define the Point value
Point = "0"

-- Define the function value
func = "no"

-- Define the error message
errormsg = "No Errors"

--Define the error function
function error()
fltk.fl_alert(errormsg)
ButtonC:take_focus()
errormsg = "No Errors"
ErrorIcon:hide()
end

-- Define the clear function
function clear()
total = "0"
erase = true
buffer = "0"
Point = "0"
func = "no"
errormsg = "No Errors"
ErrorIcon:hide()
PlusIcon:hide()
MinusIcon:hide()
TimesIcon:hide()
DivideIcon:hide()
outputWindow:value(buffer)
end

-- Define the CheckBuffer function
function CheckBuffer()
bcount = string.gsub(buffer, "%.", "")
bcount = string.len(bcount)
if bcount<17
then
outputWindow:value(buffer)
else
errormsg = "Too many digits."
ErrorIcon:show()
end
end

-- Define the calculate function
function calculate()
--fltk.fl_alert(func)
--fltk.fl_alert(buffer)
if func == "add"
then
total = value + buffer
buffer = "0"
outputWindow:value(total)
elseif func == "sub"
then
total = value - buffer
buffer = "0"
outputWindow:value(total)
elseif func == "mult"
then
total = value * buffer
buffer = "0"
outputWindow:value(total)
elseif func == "div"
then
total = value / buffer
buffer = "0"
outputWindow:value(total)
end
Point = "0"
func = "no"
PlusIcon:hide()
MinusIcon:hide()
TimesIcon:hide()
DivideIcon:hide()
a, b = string.find(total, "%a")
if a~=nil
then
errormsg = "Logical error."
ErrorIcon:show()
end
end

-- Define the Plus function
function Plus()
calculate()
erase = true
func = "add"
value = outputWindow:value()
PlusIcon:show()
MinusIcon:hide()
TimesIcon:hide()
DivideIcon:hide()
end

-- Define the Minus function
function Minus()
calculate()
erase = true
func = "sub"
value = outputWindow:value()
PlusIcon:hide()
MinusIcon:show()
TimesIcon:hide()
DivideIcon:hide()
end

-- Define the Multipy function
function Multiply()
calculate()
erase = true
func = "mult"
value = outputWindow:value()
PlusIcon:hide()
MinusIcon:hide()
TimesIcon:show()
DivideIcon:hide()
end

-- Define the Divide function
function Divide()
calculate()
erase = true
func = "div"
value = outputWindow:value()
PlusIcon:hide()
MinusIcon:hide()
TimesIcon:hide()
DivideIcon:show()
end

-- Define the ChangeSign function
function ChangeSign()
a, b = string.find(outputWindow:value(), "-")
if a~=nil
then
buffer = string.gsub(outputWindow:value(), "-", "")
outputWindow:value(buffer)
else
buffer = "-" .. outputWindow:value()
outputWindow:value(buffer)
end
end

-- Define the displayN function
function displayN(num)
if erase then
	buffer = num
	if num == '0' then erase = true end
elseif buffer == '0' then
	buffer = num
	erase = true
else
	buffer = buffer .. num
	erase = false
end
	if num ~= '0' then erase = false end
	CheckBuffer()
end

-- Define the displayPoint function
function displayPoint()
if Point == "0"
then
if erase
then
buffer = "."
else
buffer = buffer .. "."
end
Point = "1"
end
erase = false
CheckBuffer()
end

-- Define the all clear function
function AC()
memory = "0"
MemoryIcon:hide()
clear()
end

-- Define the memory plus funcion
function Mplus()
memory = memory+outputWindow:value()
MemoryIcon:show()
end

-- Define the memory minus function
function Mminus()
fltk.fl_alert(memory .. " " .. outputWindow:value())
memory = memory-outputWindow:value()
fltk.fl_alert(memory)
MemoryIcon:show()
end

-- Define the memory recall function
function MR()
outputWindow:value(memory)
end

-- Set the main window width.
ww = 240

-- Set the main window height.
wh = 410

-- Define the main window.
window = fltk.Fl_Double_Window:new_local(ww, wh, "Simple Calculator") 

-- Show the output window.
outputWindow = fltk.Fl_Output:new(5, 5, ww-25, 40)
outputWindow:textsize(22)
outputWindow:value(total)

-- Define the information icons.
ErrorIcon = fltk.Fl_Button:new(225, 5, 10, 10)
ErrorIcon:box(fltk.FL_NO_BOX)
ErrorIcon:labelsize(10)
ErrorIcon:label("E")
ErrorIcon:hide()
ErrorIcon:callback(error)

PlusIcon = fltk.Fl_Box:new(225, 20, 10, 10)
PlusIcon:box(fltk.FL_NO_BOX)
PlusIcon:labelsize(10)
PlusIcon:label("+")
PlusIcon:hide()

MinusIcon = fltk.Fl_Box:new(225, 20, 10, 10)
MinusIcon:box(fltk.FL_NO_BOX)
MinusIcon:labelsize(15)
MinusIcon:label("-")
MinusIcon:hide()

TimesIcon = fltk.Fl_Box:new(225, 20, 10, 10)
TimesIcon:box(fltk.FL_NO_BOX)
TimesIcon:labelsize(10)
TimesIcon:label("X")
TimesIcon:hide()

DivideIcon = fltk.Fl_Box:new(225, 20, 10, 10)
DivideIcon:box(fltk.FL_NO_BOX)
DivideIcon:labelsize(15)
DivideIcon:label("/")
DivideIcon:hide()

MemoryIcon = fltk.Fl_Box:new(225, 35, 10, 10)
MemoryIcon:box(fltk.FL_NO_BOX)
MemoryIcon:labelsize(10)
MemoryIcon:label("M")
MemoryIcon:hide()

--fltk.FL_ALIGN_WRAP = 128

-- Make a button.
ButtonAC = fltk.Fl_Button:new(5, 55, 50, 50, "AC"); 
ButtonAC:labelsize(15) 
ButtonAC:color(1) 
ButtonAC:align(fltk.FL_ALIGN_WRAP); 
ButtonAC:callback(AC)

-- Make a button.
ButtonMplus = fltk.Fl_Button:new(65, 55, 50, 50, "M+"); 
ButtonMplus:labelsize(15)  
ButtonMplus:color(219)
ButtonMplus:align(fltk.FL_ALIGN_WRAP); 
ButtonMplus:callback(Mplus)

-- Make a button.
ButtonMminus = fltk.Fl_Button:new(125, 55, 50, 50, "M-"); 
ButtonMminus:labelsize(15) 
ButtonMminus:color(219)
ButtonMminus:align(fltk.FL_ALIGN_WRAP); 
ButtonMminus:callback(Mminus)

-- Make a button.
ButtonMR = fltk.Fl_Button:new(185, 55, 50, 50, "MRC"); 
ButtonMR:labelsize(15)
ButtonMR:color(219)
ButtonMR:align(fltk.FL_ALIGN_WRAP); 
ButtonMR:callback(MR)

-- Make a button.
ButtonC = fltk.Fl_Button:new(5, 115, 50, 50, "C"); 
ButtonC:labelsize(15)
ButtonC:color(1)
ButtonC:align(fltk.FL_ALIGN_WRAP); 
ButtonC:shortcut(fltk.FL_Delete)
ButtonC:callback(clear)
ButtonC:take_focus()

-- Make a button.
ButtonSign = fltk.Fl_Button:new(65, 115, 50, 50, "+/-" ); 
ButtonSign:labelsize(20)
ButtonSign:color(4)
ButtonSign:align(fltk.FL_ALIGN_WRAP); 
ButtonSign:callback(ChangeSign)

-- Make a button.
ButtonDivide = fltk.Fl_Button:new(125, 115, 50, 50, "/"); 
ButtonDivide:labelsize(30)
ButtonDivide:color(4)
ButtonDivide:align(fltk.FL_ALIGN_WRAP);
ButtonDivide:shortcut("/")
ButtonDivide:callback(Divide)

-- Make a button.
ButtonMultiply = fltk.Fl_Button:new(185, 115, 50, 50, "X"); 
ButtonMultiply:labelsize(30)
ButtonMultiply:color(4)
ButtonMultiply:align(fltk.FL_ALIGN_WRAP);
ButtonMultiply:shortcut("*")
ButtonMultiply:callback(Multiply)

function mkButtonN(x,y,w,h, num)
	local Button = fltk.Fl_Button(x, y, w, h, num); 
	Button:labelsize(30)
	Button:color(39)  
	Button:align(fltk.FL_ALIGN_WRAP);
	Button:shortcut(num)
	Button:callback(function() displayN(num) end)
	return Button
end

-- Make a button.
Button7 = mkButtonN(5, 175, 50, 50, "7"); 
Button8 = mkButtonN(65, 175, 50, 50, "8"); 
Button9 = mkButtonN(125, 175, 50, 50, "9"); 

-- Make a button.
ButtonMinus = fltk.Fl_Button:new(185, 175, 50, 50, "-"); 
ButtonMinus:labelsize(30)
ButtonMinus:color(4)
ButtonMinus:align(fltk.FL_ALIGN_WRAP);
ButtonMinus:shortcut("-")
ButtonMinus:callback(Minus)

-- Make a button.
Button4 = mkButtonN(5, 235, 50, 50, "4"); 
Button5 = mkButtonN(65, 235, 50, 50, "5"); 
Button6 = mkButtonN(125, 235, 50, 50, "6"); 

-- Make a button.
ButtonPlus = fltk.Fl_Button:new(185, 235, 50, 50, "+"); 
ButtonPlus:labelsize(30)
ButtonPlus:color(4)
ButtonPlus:align(fltk.FL_ALIGN_WRAP); 
ButtonPlus:shortcut(43)
ButtonPlus:callback(Plus)

-- Make a button.
Button1 = mkButtonN(5, 295, 50, 50, "1"); 

-- Make a button.
Button2 = mkButtonN(65, 295, 50, 50, "2"); 

-- Make a button.
Button3 = mkButtonN(125, 295, 50, 50, "3"); 

-- Make a button.
Button0 = mkButtonN(5, 355, 110, 50, "0"); 

-- Make a button.
ButtonPoint = fltk.Fl_Button:new(125, 355, 50, 50, "."); 
ButtonPoint:labelsize(30)
ButtonPoint:color(39)
ButtonPoint:align(fltk.FL_ALIGN_WRAP); 
ButtonPoint:shortcut(".")
ButtonPoint:callback(displayPoint)

-- Make a button.
ButtonEqual = fltk.Fl_Button:new(185, 295, 50, 110, "="); 
ButtonEqual:labelsize(30)   
ButtonEqual:align(fltk.FL_ALIGN_WRAP)
ButtonEqual:color(4)  
ButtonEqual:shortcut(fltk.FL_KP_Enter)
ButtonEqual:callback(calculate)

window:resizable(window)

fltk.Fl:scheme("plastic")
window:show_main()
fltk.Fl:run()