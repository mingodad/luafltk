
colors = {}
row=20;switch=15;bw=20;left=10
for i = 0,255 do
colors[i]=fltk.Fl_Box:new(left+bw,row,bw,bw)
colors[i]:color(i)
colors[i]:box(fltk.FL_THIN_UP_BOX)
colors[i]:tooltip("color "..i)
left=left+bw
if i == switch then
switch = switch+16
row = row+bw
left = 10
end
end

function colormap_cb()
	local newcolor=fltk.fl_show_colormap(colormap:color())
--	colormap:hide() -- so there is no label overlap
	colormap:color(newcolor)
	colormap:label("FLTK Color "..newcolor)
	demo_widget:redraw()
--	colormap:show()
--	colormap:set_changed()
--	colormap:redraw_label()
--        Fl:flush()
end


--pop=fltk.Fl_Return_Button(left+bw,row+bw,bw*16,80,"push for built-in color map")
colormap=fltk.Fl_Button:new(380,20,100,80,"fl_show_colormap")
colormap:align(fltk.FL_ALIGN_BOTTOM)
colormap:callback(colormap_cb)

colorchooser=fltk.Fl_Button:new(380,125,100,80,"fl_color_chooser")
colorchooser:align(fltk.FL_ALIGN_BOTTOM)
colorchooser:color(15)
colorchooser:callback(
function(colorchooser_cb)
	local color_ok,r,g,b -- initialize local variables
	r = 0
	g = 0
	b = 0
	r,g,b=fltk.Fl:get_color_rgb(colorchooser:color(),r,g,b)
	color_ok,r,g,b=fltk.fl_color_chooser("blah",r,g,b)
	if color_ok == 1 then -- color_ok represents the first value (exit status) returned by fl_color_chooser
	hexcolor=string.format("#%.2X%.2X%.2X",r,g,b) -- convert the rgb values to hex
--	colorchooser:hide()
	fltk.Fl:set_color(15,r,g,b) -- change color 15
	-- set the color_cube box color 
	color_cube:color(fltk.fl_color_cube(r * (fltk.FL_NUM_RED - 1) / 255,g * (fltk.FL_NUM_GREEN - 1) / 255,b * (fltk.FL_NUM_BLUE - 1) / 255))
	color_cube:label("fl_color_cube: "..color_cube:color())
	colorchooser:label("Color "..colorchooser:color().." (modified)\nRGB "..r.." "..g.." "..b.."\nHTML "..hexcolor)
--	colorchooser:show()
	demo_widget:redraw()
	end
end
)

color_cube=fltk.Fl_Box:new(380,260,100,80,"fl_color_cube")
color_cube:align(fltk.FL_ALIGN_BOTTOM)
color_cube:box(fltk.FL_UP_BOX)

