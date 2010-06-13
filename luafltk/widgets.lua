#!/bin/murgaLua
--#!/usr/bin/murgaLua-0.5.5
--#!/usr/bin/murgaLua-0.5.5_nonXft

--[[

  MurgaLua demos of FLTK widgets and functions
  mikshaw 2007-2008
  Requires MurgaLua version 0.5.5
  Version 0.6+ is recommended and will eventually be required
 
  This program is free software released under the
  Creative Commons "by-nc-sa" license, version 3.0
  http://creativecommons.org/licenses/by-nc-sa/3.0/

  All global variable and function names in this script begin
  with "demo_" to prevent clobbering by external scripts.

  These scripts are much more heavily commented than a typical
  script should be, due to the fact that their purpose is to
  help teach the language itself.
 
--]]
murgaLua = {}
murgaLua.Fl_murgaLuaTimer2 = {active = false, ref = 0, cb = nil, delay = 0.1}

function murgaLua.Fl_murgaLuaTimer2:doWait2(t)
	self.delay = t
	self.active = self.delay > 0
	--fltk.Fl->remove_idle(self.ref)
	if self.active then
		if self.ref ~= 0 then
			fltk.Fl->repeat_timeout(self.delay, self.ref)
		else
			self.ref = fltk.Fl->add_timeout(self.delay, self.cb)
		end
	else
		self.ref = 0
	end
	--print('doWait ', t)
end

function murgaLua.Fl_murgaLuaTimer2:doWait(t)
	self.delay = t
	self.active = self.delay > 0
	fltk.Fl->remove_idle(self.ref)
	self.ref = 0
	if self.active then
		self.ref = fltk.Fl->add_timeout(self.delay, self.cb)
	end
	--print('doWait ', t)
end

function murgaLua.Fl_murgaLuaTimer2:callback(cb)
	self.cb = cb
end

function murgaLua.Fl_murgaLuaTimer2:isActive()
	return self.active
end

function murgaLua.Fl_murgaLuaTimer2:do_callback()
	self:doWait(self.delay)
end

function murgaLua.Fl_murgaLuaTimer2:new(o)
	o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o
end

function murgaLua.createFltkTimer()
	return murgaLua.Fl_murgaLuaTimer2:new()
end

-- change this to your favorite text viewer/editor
external_viewer="aterm -e vim"

-- this part is used for the progress bar example
-- it is run each time a widget is loaded --see demo_menu_callback()
demo_widgets_seen={} -- table of widgets that have been loaded
demo_progress=0 -- initialize the global progress variable
function demo_check_progress(widget)
  -- check if the chosen widget is in the "seen" table
  -- initialize a local variable to use as the search result
  local isit=0
  for i=1,table.getn(demo_widgets_seen) do
    if widget==demo_widgets_seen[i] then
      isit=1
      break
    else
      isit=0
    end
  end
  -- after going through the loop, isit should be 0 if widget wasn't found
  -- in that case, add it to the table
  if isit==0 then table.insert(demo_widgets_seen,widget) end
  local progress=table.getn(demo_widgets_seen)/demo_num_widgets*100 -- % viewed of total widgets
  demo_progress=math.floor(progress) -- round it off to an integer for the global variable
end

function demo_load_text(file,title,fixed,snip)
  local textfile=io.open(file,"r")
  if textfile then 
    demo_remove_widget()
--    demo_code_item:deactivate()
    if title then demo_widget_title:label(title) end -- change the title of current script/file
    if snip ~= 1 then
      demo_edit_item:deactivate()
--      demo_notes_item:deactivate()
    end -- **
    textfile:close()
    demo_display_buffer:loadfile(file) -- **
    if fixed==1 then
      demo_text_display:textfont(fltk.FL_COURIER) -- switch to fixed-width for code display
    else
      demo_text_display:textfont(fltk.FL_HELVETICA)
    end
    if demo_widget then demo_widget:hide() end
    demo_text_display:show()
    demo_text_display:redraw()
    demo_widget_title:redraw_label()
  end
end

function demo_edit()
  demo_editor_buffer:loadfile(demo_current_file)
  demo_remove_widget() -- mainly to prevent heavier scripts running twice
  -- needed to add some global variables for the preview. No menu bar, so demo_bh is reset to zero
  demo_editor_buffer:insert(0,"demo_appdir=\""..demo_appdir.."\"\ndemo_images=\""..demo_images.."\"\ndemo_bh=0\ndemo_widget=fltk.Fl_Double_Window("..demo_ww..","..demo_wh..",\"my script\")\n")
  demo_editor_buffer:append("\ndemo_widget:show()\nfltk.Fl:run()")
  demo_editor_window:label(demo_widget_title:label().." (edit)")
  demo_editor_label:label(demo_widget_title:label())
  demo_editor_window:show()
end

x = 0
appHelpDialog = nil
function NewHelpDialog()
	x = x+1
	print(x)
	if not appHelpDialog then
		appHelpDialog = fltk.Fl_Help_Dialog()
	end
	return appHelpDialog
end

function demo_show_help(url)
local help=NewHelpDialog() -- this is a built-in "megawidget"
help:load(url)
help:show()
end

function demo_show_readme()
  demo_current_file=arg[0]
  demo_load_text(demo_appdir..demo_sep.."README",demo_title)
end

function demo_preview()
if not murgaLua_ExePath then
  fltk.fl_message("The preview feature requires murgaLua 0.6 or later")
else
  local filename=os.tmpname()
  demo_editor_buffer:savefile(filename)
  os.execute(murgaLua_ExePath.." "..filename)
  os.remove(filename)
end
end

function demo_save_file()
  local filename=fltk.fl_file_chooser("save code as...","*.lua",".",0)
  if filename then
    local output=io.open(filename,"w+")
    if output then
      output:close()
      demo_editor_buffer:savefile(filename)
    end
  end
end

function demo_remove_widget()
  if demo_widget then
    -- remove previous widget
    demo_widget:hide()
    demo_w:remove(demo_widget)
	--demo_widget is garbage collected
    --fltk.Fl:delete_widget(demo_widget)
    demo_widget=nil
  end
end

function demo_replace_widget(new_file)
  demo_remove_widget()
  -- new child window for new widget
  demo_widget=fltk.Fl_Double_Window(0,demo_bh,demo_ww,demo_wh-demo_bh,demo_widget_files[i])
  dofile(new_file)
  --fltk.Fl_End(demo_widget) -- end for each widget window
  demo_widget->endd()
  demo_w:add(demo_widget)
  demo_widget:show()
  demo_widget:make_current() -- needed for drawing functions
end

function demo_menu_callback()
  if demo_menu_bar:text()==demo_notes_item:label() and demo_notes_file then demo_load_text(demo_notes_file,demo_notes_label,0,0)
  elseif demo_menu_bar:text()=="&view code" then demo_load_text(demo_current_file,nil,1,1)
  elseif demo_menu_bar:text()=="view &main script code" then demo_load_text(arg[0],"main code",1,0)
  elseif demo_menu_bar:text()=="&edit" then demo_edit()
  elseif demo_menu_bar:text()=="&code snippets" then demo_load_text(demo_appdir..demo_sep.."doc"..demo_sep.."snippets.txt","code snippets",1,0)
  elseif demo_menu_bar:text()=="porting &issues" then demo_load_text(demo_appdir..demo_sep.."doc"..demo_sep.."porting.txt","porting issues",0,0)
  elseif demo_menu_bar:text()=="show &README" then demo_show_readme()
  elseif demo_menu_bar:text()=="&Lua manual" then demo_show_help(demo_appdir..demo_sep.."doc"..demo_sep.."lua"..demo_sep.."contents.html")
  elseif demo_menu_bar:text()=="&text color" then demo_set_color()
  elseif demo_menu_bar:text()=="&background color" then demo_set_color("bg")
  elseif demo_menu_bar:text()=="&plastic" or demo_menu_bar:text()=="&gtk+" or demo_menu_bar:text()=="&none" then 
	local schemeStr = string.gsub(demo_menu_bar:text(),"&","")
	fltk.Fl:scheme(schemeStr); 
	demo_w:redraw()
  elseif string.find(demo_menu_bar:text(),"%d%&%d") then
	  local textsizeStr = string.gsub(demo_menu_bar:text(),"&","")
	  demo_text_display:textsize(textsizeStr)
	  demo_text_display:redraw()
	  demo_editor:textsize(textsizeStr)
	  demo_editor:redraw()
  else -- if it's a widget file
    for i=1,demo_num_widgets do
--      print(demo_widget_files[i]) -- debug
      if demo_menu_bar:text()..".lua"==demo_widget_files[i] then
        demo_check_progress(demo_menu_bar:text())
        demo_code_item:activate() -- **
        demo_edit_item:activate() -- **
        demo_text_display:hide()
        demo_current_file=demo_appdir..demo_sep.."script"..demo_sep..demo_widget_files[i]
	demo_replace_widget(demo_current_file)
        -- activate "notes" menu item if a txt file exists for the current widget:
	if string.find(demo_notes_string,demo_widget_files[i]..".txt",1,1) then
--	  demo_notes_item:activate()
	  demo_notes_label=demo_menu_bar:text().." notes"
	  demo_notes_file=demo_current_file..".txt"
	--  print("\nyes there are notes\n"..demo_notes_file.."\n") --debug
        else
	--  print("\nno notes\n") --debug
	  demo_notes_file=nil
--	  demo_notes_item:deactivate()
	end
	demo_widget_title:label(demo_widget_files[i]) -- change the label for the current widget
	demo_widget_title:redraw()
	break
      end
    end
  end
end

function demo_exit()
  local confirm=fltk.fl_choice("sure you want to quit?","stay","quit",NULL)
  if confirm == 1 then os.exit(0) else demo_w:show() end
end

function demo_set_color(forb)
  local which,R,G,B, r,g,b
  r = 0
  g = 0
  b = 0
  if forb == "bg" then which=fltk.FL_BACKGROUND_COLOR else which=fltk.FL_FOREGROUND_COLOR end
  local color_ok,r,g,b=fltk.fl_color_chooser("pick a color",fltk.Fl:get_color_rgb(which,r,g,b))
  if color_ok == 1 then
    if forb == "bg" then
      fltk.Fl:background(r,g,b)
      -- make text fields slightly lighter (up to 255)
      -- This could probably be done with fl_lighter(), but would
      -- require converting RGB to indexed color and back again.
      R,G,B=r+30,g+30,b+30
      if R>255 then R=255 end
      if G>255 then G=255 end
      if B>255 then B=255 end
      fltk.Fl:background2(R,G,B)
    else
      fltk.Fl:foreground(r,g,b)
    end
    demo_w:redraw()
    if demo_widget then demo_widget:redraw() end
  end
end

-- BEGIN INTERFACE

-- inherit a user-specified FLTK scheme, if it exists
fltk.Fl:scheme(NULL)

--[[
     change the default sans-serif font to serif
     because it is easier to distiguish some letters, such as capital I and lowercase L
     EDIT: I commented this out in order to more accurately show 
     the available fonts in fonts-system.lua
]]
--Fl:set_font(fltk.FL_HELVETICA,Fl:get_font(fltk.FL_TIMES))

-- apply user-specified colors (Xdefaults, for example), if they exist
fltk.Fl:get_system_colors()

-- inital font size of text viewer and editor
demo_text_size=12

-- set directory separator according to operating system
--if murgaLua.getHostOsName() == "windows" then demo_sep="\\" else demo_sep="/" end
if os.getenv("WINDIR") then demo_sep="\\" else demo_sep="/" end
-- Get the dirname and basename of the current script
if string.find(arg[0],demo_sep) then
  demo_appdir=string.gsub(arg[0],"(.*)"..demo_sep..".*","%1") -- data directory
  demo_title=string.gsub(arg[0],".*"..demo_sep.."(.*)","%1")
else
  demo_appdir="."
  demo_title=arg[0]
end

-- images directory
demo_images=demo_appdir..demo_sep.."images"..demo_sep

fltk.Fl_File_Icon:load_system_icons() -- load system icons for Fl_File_Browser()

lua_icon=fltk.Fl_File_Icon("*.lua",1)
--print('Here !')
lua_icon:load(demo_images.."greenguy.xpm")

-- change the message icon, kinda messy
demo_message_icon=fltk.fl_message_icon() -- create a pointer to message icon
--demo_message_icon:image(fltk.Fl_XPM_Image(demo_images.."fish-eyes.xpm"))
demo_message_icon:image(fltk.Fl_PNG_Image(demo_images.."smiles.png"))
demo_message_icon:align(85) -- set the above image inside top left of icon area (hides the text label)

demo_ww=600; demo_wh=480; demo_bh=30 -- window and menu dimensions
demo_w=fltk.Fl_Double_Window(demo_ww,demo_wh,"MurgaLua FLTK Widgets Demo") -- main window

demo_display_buffer=fltk.Fl_Text_Buffer() -- **
demo_text_display=fltk.Fl_Text_Display:new(0,demo_bh,demo_ww,demo_wh-demo_bh) -- ** text display
demo_text_display:buffer(demo_display_buffer) -- **
demo_text_display:textsize(demo_text_size) -- initial size of text
demo_text_display:selection_color(fltk.FL_BLACK)
demo_w:resizable(demo_text_display)

demo_widget_title=fltk.Fl_Button:new(demo_ww-300,0,300,demo_bh,demo_title) -- displays the name of the current widget file
demo_widget_title:box(fltk.FL_THIN_UP_BOX)
demo_widget_title:callback(
function()
  if external_viewer and demo_current_file then
    os.execute(external_viewer.." "..demo_current_file.." &")
  end
end
)

--demo_menu_bar_group=fltk.Fl_Group(0,0,demo_ww-200,demo_bh)
demo_menu_bar=fltk.Fl_Menu_Bar:new(0,0,demo_ww-300,demo_bh)
demo_menu_bar:selection_color(fltk.FL_WHITE) -- blue is an annoying color
--fltk.Fl_End()

demo_widget_files={} -- *.lua filenames in the script directory
demo_notes_files={} -- *.lua.txt filenames in the script directory, for finding notes
for i in lfs.dir(demo_appdir..demo_sep.."script") do
  if string.find(i,"%.lua$") then table.insert(demo_widget_files,i)
  elseif string.find(i,"%.lua%.txt$") then table.insert(demo_notes_files,i) end
end
-- create a string containing all available notes filenames (easier than searching through a table)
demo_notes_string=table.concat(demo_notes_files,"\n")
--print(demo_notes_string) --debug
table.sort(demo_widget_files) -- alphabetize the file list
demo_num_widgets=table.getn(demo_widget_files) --total number of widgets
for i=1,demo_num_widgets  do -- add a menu item for each widget
    demo_menu_bar:add("&widgets/&"..string.sub(demo_widget_files[i],1,1).."/"..string.gsub(demo_widget_files[i],"%.lua$",""))
end
demo_menu_bar:add("&code/&view code")
demo_menu_bar:add("&code/&edit")
demo_menu_bar:add("&code/&notes about current widget")
demo_menu_bar:add("&code/view &main script code")
demo_menu_bar:add("&view/&scheme/&plastic")
demo_menu_bar:add("&view/&scheme/&gtk+")
demo_menu_bar:add("&view/&scheme/&none")
for i=0,8 do demo_menu_bar:add("&view/&font size/1&"..i) end
demo_menu_bar:add("&view/&text color")
demo_menu_bar:add("&view/&background color")
demo_menu_bar:add("&help/show &README")
demo_menu_bar:add("&help/&Lua manual")
demo_menu_bar:add("&help/&code snippets")
demo_menu_bar:add("&help/porting &issues")
demo_menu_bar:callback(demo_menu_callback)
demo_menu_bar:box(fltk.FL_THIN_UP_BOX)
demo_menu_bar:down_box(fltk.FL_THIN_DOWN_BOX)

-- create pointers to certain items for toggling their status:
demo_notes_item=demo_menu_bar:find_item("&code/&notes about current widget")
demo_code_item=demo_menu_bar:find_item("&code/&view code")
demo_edit_item=demo_menu_bar:find_item("&code/&edit")

fltk.Fl_End() -- end of main window

--demo_notes_item:deactivate() -- initially deactivate the "notes" feature
demo_show_readme() -- start with README displayed

demo_editor_window=fltk.Fl_Double_Window(demo_ww,demo_wh)
demo_editor_buffer=fltk.Fl_Text_Buffer()
demo_editor=fltk.Fl_Text_Editor:new(0,demo_bh,demo_ww,demo_wh-demo_bh)
demo_editor:textfont(fltk.FL_COURIER)
demo_editor:textsize(demo_text_size) -- initial size of text
demo_editor:buffer(demo_editor_buffer)
demo_editor_window:resizable(demo_editor)

demo_editor_preview=fltk.Fl_Button:new(0,0,demo_ww/4,demo_bh,"&preview changes")
demo_editor_save=fltk.Fl_Button:new(demo_ww/4,0,demo_ww/4,demo_bh,"&save as...")
demo_editor_label=fltk.Fl_Box:new(demo_ww/2,0,demo_ww/2,demo_bh)
demo_editor_preview:callback(demo_preview)
demo_editor_save:callback(demo_save_file)

demo_w:callback(demo_exit)
demo_w:show() -- show the main interface
fltk.Fl:run()
