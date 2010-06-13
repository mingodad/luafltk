-- drawing simple objects
-- based on drawing tests by John Murga

math.randomseed(os.time()) -- random seed for math.random()

local recordedDraws = {}

function saveDraws(func, ...)
	local fargs = {...}
	func(unpack(fargs))
	table.insert(recordedDraws, {func, fargs, fltk.fl_color()})
end

function myfl_rect(...)
	saveDraws(fltk.fl_rect, ...)
end

function myfl_rectf(...)
	saveDraws(fltk.fl_rectf, ...)
end

function myfl_xyline(...)
	saveDraws(fltk.fl_xyline, ...)
end

function myfl_yxline(...)
	saveDraws(fltk.fl_yxline, ...)
end

function myfl_loop(...)
	saveDraws(fltk.fl_loop, ...)
end

function myfl_polygon(...)
	saveDraws(fltk.fl_polygon, ...)
end

function myfl_arc(...)
	saveDraws(fltk.fl_arc, ...)
end

function myfl_pie(...)
	saveDraws(fltk.fl_pie, ...)
end

function myfl_circle(...)
	saveDraws(fltk.fl_circle, ...)
end

function myfl_point(...)
	saveDraws(fltk.fl_point, ...)
end

function myfl_line(...)
	saveDraws(fltk.fl_line, ...)
end

function draw_something(self)
demo_widget:make_current() -- needed for all drawing functions
-- fltk.fl_color(draw_color) -- use with color slider (comment the next line)
fltk.fl_color(math.random(1,255))
-- Linux will segfault unless we set the font before using fl_draw
fltk.fl_font(fltk.FL_HELVETICA_BOLD,20)
fltk.fl_draw("drawing simple shapes in murgaLua",10,20) -- drawing some text, overlaps the color slider:w

-- the first 5 need to be more restricted in size and position to prevent bleeding beyond the white space
if self:label() == "box" then myfl_rect(math.random(210,400),math.random(30,200),math.random(25,100),math.random(25,100))
elseif self:label() == "filled box" then myfl_rectf(math.random(210,400),math.random(30,200),math.random(25,100),math.random(25,100))
elseif self:label() == "arc" then myfl_arc(math.random(210,300),math.random(30,100),math.random(100,200),math.random(100,200),math.random(0,360),math.random(0,360))
elseif self:label() == "pie" then myfl_pie(math.random(210,300),math.random(30,100),math.random(100,200),math.random(100,200),math.random(0,360),math.random(0,360))
elseif self:label() == "circle" then myfl_circle(math.random(260,450),math.random(80,250),math.random(25,50))
else -- the rest can use points anywhere within draw_display, so we can set generic coordinates for all
  local x=math.random(210,500) -- pick a random x position within draw_display
  local y=math.random(30,300)  -- these positions are related to the size and position of draw_display
  local x2=math.random(210,500)
  local y2=math.random(30,300)
  local x3=math.random(210,500)
  local y3=math.random(30,300)
  local x4=math.random(210,500)
  local y4=math.random(30,300)
  if self:label() == "point" then myfl_point(x,y)
  elseif self:label() == "line" then myfl_line(x,y,x2,y2)
  elseif self:label() == "angle" then myfl_line(x,y,x2,y2,x3,y3)
  elseif self:label() == "triangle" then myfl_loop(x,y,x2,y2,x3,y3)
  elseif self:label() == "quadrangle" then myfl_loop(x,y,x2,y2,x3,y3,x4,y4)
  elseif self:label() == "filled tri" then myfl_polygon(x,y,x2,y2,x3,y3)
  elseif self:label() == "filled quad" then myfl_polygon(x,y,x2,y2,x3,y3,x4,y4)
  elseif self:label() == "xy line" then myfl_xyline(x,y,x2)
  elseif self:label() == "xy line2" then myfl_xyline(x,y,x2,y2)
  elseif self:label() == "xy line3" then myfl_xyline(x,y,x2,y2,x3)
  elseif self:label() == "yx line" then myfl_yxline(x,y,y2)
  elseif self:label() == "yx line2" then myfl_yxline(x,y,y2,x2)
  elseif self:label() == "yx line3" then myfl_yxline(x,y,y2,x2,y3)
  end
end
io.flush()
end

function print_cb(me, win)
	--fltk.fl_message('Hello !')
	printer = fltk.Fl_Printer()
	
	if printer:start_job(1) then
		--fltk.fl_message('problem starting print job !')
		--return
	end
	if printer:start_page() then
		--fltk.fl_message('problem starting page !')
		--return 
	end
	local w, h = printer:printable_rect()
	fltk.fl_color(fltk.FL_GRAY)
	fltk.fl_line_style(fltk.FL_DOT, 0)
	fltk.fl_rect(0,0,w,h)
	fltk.fl_line_style(fltk.FL_SOLID, 0)
	--printer:print_widget(me)
	
		for k,v in ipairs(recordedDraws) do
			--demo_widget:make_current() -- needed for all drawing functions
			fltk.fl_color(v[3])
			v[1](unpack(v[2]))
			--print(k, v[3], unpack(v[2]))
		end
	
	-- close page and print job
	printer:end_page()
	printer:end_job()
end

draw_display=fltk.Fl_Box:new(210,30,300,270) -- a white box over which to draw
draw_display:color(fltk.FL_WHITE)
draw_display:box(fltk.FL_FLAT_BOX)

btn = fltk.Fl_Button:new(draw_display:x(),draw_display:y()+draw_display:h()+5,100,30, 'Print')
btn:callback(function()
		print_cb()
		--draw_display:redraw()
		for k,v in ipairs(recordedDraws) do
			demo_widget:make_current() -- needed for all drawing functions
			fltk.fl_color(v[3])
			v[1](unpack(v[2]))
			--print(k, v[3], unpack(v[2]))
		end
	end)


draw_butts={} -- a table and a loop makes it easy to create an array of similar widgets
b_left=10 -- left edge of buttons, used for shifting the x position after laying out half the buttons
b_top=0   -- after the shift, the y position needs to be backed up a bit too
for i=1,18 do
if i > 9 then b_left=110; b_top=270 end -- the shift
draw_butts[i]=fltk.Fl_Button:new(b_left,i*30-b_top,100,30)
draw_butts[i]:callback(draw_something)
end

-- set the labels for each of the buttons created above ("pos" means "position")
draw_butts[1]:label("point") -- fltk.fl_point(x_position,y_position)
draw_butts[2]:label("box") -- myfl_rect(x_pos,y_pos,width,height
draw_butts[3]:label("filled box") -- myfl_rectf(x_pos,y_pos,width,height)
draw_butts[4]:label("line") -- fltk.fl_line(x_pos1,y_pos1,x_pos2,y_pos2)
draw_butts[5]:label("angle") -- fltk.fl_line(x_pos1,y_pos1,x_pos2,y_pos2,x_pos3,y_pos3)
draw_butts[6]:label("triangle") -- fltk.fl_loop(x_pos1,y_pos1,x_pos2,y_pos2,x_pos3,y_pos3)
draw_butts[7]:label("quadrangle") -- fltk.fl_loop(x_pos1,y_pos1,x_pos2,y_pos2,x_pos3,y_pos3,x_pos4,y_pos4)
draw_butts[8]:label("filled tri") -- fltk.fl_polygon(x_pos1,y_pos1,x_pos2,y_pos2,x_pos3,y_pos3)
draw_butts[9]:label("filled quad") -- fltk.fl_polygon(x_pos1,y_pos1,x_pos2,y_pos2,x_pos3,y_pos3,x_pos4,y_pos4)
draw_butts[10]:label("xy line") -- myfl_xyline(x_pos1,y_pos1,x_pos2) <-- horizontal line
draw_butts[11]:label("xy line2") -- myfl_xyline(x_pos1,y_pos1,x_pos2,y_pos2) <-- right angle
draw_butts[12]:label("xy line3") -- myfl_xyline(x_pos1,y_pos1,x_pos2,y_pos2,x_pos3) <-- 2 right angles connected at y_pos2
draw_butts[13]:label("yx line")
draw_butts[14]:label("yx line2")
draw_butts[15]:label("yx line3")
draw_butts[16]:label("arc") -- fltk.fl_arc(x_pos,y_pos,width,height,start_degree,end_degree)
draw_butts[17]:label("pie") -- fltk.fl_pie(x_pos,y_pos,width,height,start_degree,end_degree)
draw_butts[18]:label("circle") -- fltk.fl_circle(x_center_pos,y_center_pos,radius)

--[[
-- change the color with a slider
draw_color=58
color_display=fltk.Fl_Box(10,0,100,30) -- color preview box
color_display:box(fltk.FL_FLAT_BOX)
color_display:color(draw_color)
color_slider=fltk.Fl_Slider(110,0,400,30)
color_slider:type(fltk.FL_HOR_NICE_SLIDER)
color_slider:step(1)
color_slider:minimum(0)
color_slider:maximum(255)
color_slider:value(draw_color)
color_slider:callback(function(cslide_cb)
draw_color=color_slider:value()
color_display:color(color_slider:value())
color_display:redraw()
end)
]]
