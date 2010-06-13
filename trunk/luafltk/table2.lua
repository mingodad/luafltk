function print_cb(me, win)
	--fltk.fl_message('Hello !')
	local printer = fltk.Fl_Printer:new_local()
	
	local sj = printer:start_job(1)
	--print(sj)
	if sj ~= 0 then
		fltk.fl_message('problem starting print job !')
		return
	end
	local sp = printer:start_page()
	--print(sp)
	if sp ~= 0 then
		fltk.fl_message('problem starting page !')
		return 
	end
	printer:set_current()
	local w, h = printer:printable_rect()
	fltk.fl_color(fltk.FL_GRAY)
	fltk.fl_line_style(fltk.FL_DOT, 0)
	fltk.fl_rect(0,0,w,h)
	fltk.fl_line_style(fltk.FL_SOLID, 0)
	fltk.fl_line(0,0, w,h)
	printer:origin((w / 2) - (fltable:w() / 2), (h / 2) - fltable:h())
	printer:print_widget(fltable)
	printer:origin((w / 2) - (fltable2:w() / 2), (h / 2) + fltable2:h())
	printer:print_widget(fltable2)
	-- close page and print job
	printer:end_page()
	printer:end_job()
	printer:delete()
end

y = 10
window = fltk.Fl_Double_Window:new(300,555)

pbut = fltk.Fl_Button:new(110, y, 50, 25, "Print")
--pbut:callback(print_cb, window);


function iif(cond, onTrue, onFalse) if cond then return onTrue end return onFalse end

my_on_draw_cell0 = function(self, context, R, C, X, Y, W, H)
	--print(context, R, C, X, Y, W, H, string.format('%d:%d', R, C))
	if context == self.CONTEXT_CELL then
		fltk.fl_push_clip(X, Y, W, H)
		
		-- BG COLOR
		--fltk.fl_color( iif(self:row_selected(R) == 1, fltk.FL_BLUE, fltk.FL_WHITE));
		fltk.fl_color( fltk.FL_WHITE);
		fltk.fl_rectf(X, Y, W, H);
		-- TEXT
		fltk.fl_color(fltk.FL_BLACK);
		fltk.fl_draw(string.format('00 -> %d:%d', R, C), X, Y, W, H, fltk.FL_ALIGN_CENTER);
		-- BORDER
		fltk.fl_color(fltk.FL_LIGHT2);
		fltk.fl_rect(X, Y, W, H);

		fltk.fl_pop_clip();	
	end
end

my_on_draw_cell = function(self, context, R, C, X, Y, W, H)
	--print(context, R, C, X, Y, W, H, string.format('%d:%d', R, C))
	if context == self.CONTEXT_CELL then
		fltk.fl_push_clip(X, Y, W, H)
		
		-- BG COLOR
		--fltk.fl_color( iif(self:row_selected(R) == 1, fltk.FL_BLUE, fltk.FL_WHITE));
		fltk.fl_color( fltk.FL_WHITE);
		fltk.fl_rectf(X, Y, W, H);
		-- TEXT
		fltk.fl_color(fltk.FL_BLACK);
		fltk.fl_draw(string.format('%d:%d', R, C), X, Y, W, H, fltk.FL_ALIGN_CENTER);
		-- BORDER
		fltk.fl_color(fltk.FL_LIGHT2);
		fltk.fl_rect(X, Y, W, H);

		fltk.fl_pop_clip();	
	end
end

--mt.on_draw_cell = my_on_draw_cell

--mt.on_cols = function(self,icols)
	-- print(self, icols)
	-- return icols
-- end

-- mt.on_rows = function(self,irows)
	-- print(self, irows)
	-- return irows
-- end

-- mt.on_clear = function(self)
	-- print('on_clear')
-- end


function my_draw_cell(self, context, R, C, X, Y, W, H)
	--print(context, R, C, X, Y, W, H, string.format('%d:%d', R, C))
	if context == self.CONTEXT_CELL then
		fltk.fl_push_clip(X, Y, W, H)
		
		-- BG COLOR
		--fltk.fl_color( iif(self:row_selected(R) == 1, fltk.FL_BLUE, fltk.FL_WHITE));
		fltk.fl_color( fltk.FL_WHITE);
		fltk.fl_rectf(X, Y, W, H);
		-- TEXT
		fltk.fl_color(fltk.FL_BLACK);
		fltk.fl_draw(string.format('%d:%d', R, C), X, Y, W, H, fltk.FL_ALIGN_CENTER);
		-- BORDER
		fltk.fl_color(fltk.FL_LIGHT2);
		fltk.fl_rect(X, Y, W, H);

		fltk.fl_pop_clip();	
	end
end

local CustomTable = {}
CustomTable.__index = CustomTable

CustomTable.draw_cell = my_draw_cell

function CustomTable:new(x,y,w,h)

   -- create a table and make it an 'instance' of CustomWidget
   local t = {}
   setmetatable(t, CustomTable)

   -- create a Lua__Widget object, and make the table inherit from it
   local w = fltk.Lua__Fl_Table:new(x,y,w,h)
   tolua.setpeer(w, t) -- use 'tolua.inherit' on lua 5.0

   -- 'w' will be the lua object where the virtual methods will be looked up
   w:tolua__set_instance(w)

   return w -- return 't' on lua 5.0 with tolua.inherit
end

my_draw_cell2 = function(self, context, R, C, X, Y, W, H)
	--print(context, R, C, X, Y, W, H, string.format('%d:%d', R, C))
	if context == self.CONTEXT_CELL then
		fltk.fl_push_clip(X, Y, W, H)
		
		-- BG COLOR
		fltk.fl_color( iif(self:row_selected(R) == 1, self:selection_color(), fltk.FL_WHITE));
		--fltk.fl_color( fltk.FL_WHITE);
		fltk.fl_rectf(X, Y, W, H);
		-- TEXT
		fltk.fl_color(fltk.FL_BLACK);
		fltk.fl_draw(string.format('%d:%d', R, C), X, Y, W, H, fltk.FL_ALIGN_CENTER);
		-- BORDER
		fltk.fl_color(fltk.FL_LIGHT2);
		fltk.fl_rect(X, Y, W, H);

		fltk.fl_pop_clip();	
	end
end

local CustomTable_Row = {}
CustomTable_Row.__index = CustomTable_Row

CustomTable_Row.draw_cell = my_draw_cell2

function CustomTable_Row:new(x,y,w,h)

   -- create a table and make it an 'instance' of CustomWidget
   local t = {}
   setmetatable(t, CustomTable)

   -- create a Lua__Widget object, and make the table inherit from it
   local w = fltk.Lua__Fl_Table_Row:new(x,y,w,h)
   tolua.setpeer(w, t) -- use 'tolua.inherit' on lua 5.0

   -- 'w' will be the lua object where the virtual methods will be looked up
   w:tolua__set_instance(w)

   return w -- return 't' on lua 5.0 with tolua.inherit
end

fltable0 = CustomTable:new(20, y+40, 250, 150)
--fltable0 = fltk.Fl_Table:new(20, y+40, 250, 150)
fltable0:endd()
fltable0:cols(4)
fltable0:rows(10)

--fltable2 = Fl_Table_Row.new(20, fltable0:y() + fltable0:h() + 10, 250, 150)
fltable2 = CustomTable_Row:new(20, fltable0:y() + fltable0:h() + 10, 250, 150)
fltable2:selection_color(fltk.FL_YELLOW)
fltable2:endd()

fltable2:cols(4)
fltable2:rows(10)

window:resizable(window)
window:show_main()
fltk.Fl:run()