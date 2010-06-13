--	======================================================================
--	File:    testtable.cxx
--	Program: testtable
--	Version: 0.1.0
--	Started: 11/21/99
--
--	Copyright (C) 1999 Laurence Charlton
--
--	Description:
--	Example of using an Flv_Table
--	======================================================================


function get_value( R,  C )
	local buf = ''
	local aval = string.byte('A')
	if (R==-1 and C>-1)	then			--	Row header, A, B, C...
		buf = string.format("%s%s", 
			string.char(C/26 + aval-1), 
			string.char((C%26) + aval) );
		if (buf < 'A') then 
			buf = buf:sub(2);
		end
	elseif (C==-1 and R>-1)	then --	Column header 1, 2, 3...
		buf = string.format("%d", R );
	elseif (R>-1 and C>-1)	then	--	Normal cell blank
		buf = string.format("%d:%d", R, C )
	end
	return buf;
end

local Flv_Table_Child = {}

Flv_Table_Child.__index = Flv_Table_Child

function Flv_Table_Child:new(x,y,w,h,l)

   -- create a table and make it an 'instance' of CustomWidget
   local t = {}
   setmetatable(t, Flv_Table_Child)

   -- create a Lua__Widget object, and make the table inherit from it
   local w = flvw.Lua__Flv_Table:new(x,y,w,h,l)
   tolua.setpeer(w, t) -- use 'tolua.inherit' on lua 5.0

   -- 'w' will be the lua object where the virtual methods will be looked up
   w:tolua__set_instance(w)

   return w -- return 't' on lua 5.0 with tolua.inherit
end

function Flv_Table_Child:draw_cell( Offset, X, Y, W, H, R, C )
	local s = flvw.Flv_Style();
	self:get_style(s, R, C);
	self:Flv_Table__draw_cell(Offset,X,Y,W,H,R,C);
	fltk.fl_draw(get_value(R,C), X-Offset, Y, W, H, s:align() );
end

function tbl_cb(l)
	if (l->clicks() > 3) then
		fltk.fl_message( string.format("Why: %d, Clicks: %d", l->why_event(), l->clicks()) );
	end
end

function main()

	w = fltk.Fl_Double_Window:new( 600, 400, "Test table" );
	l = Flv_Table_Child:new( 10, 10, 580, 380, "Sample Spreadsheet View" );
	w->endd();
	w->resizable(l);

	l->max_clicks(3);
	l->callback_when( bit.bor(flvw.FLVEcb_ROW_HEADER_CLICKED, flvw.FLVEcb_CLICKED) );
	l->callback(tbl_cb);

	l->selection_color(fltk.FL_BLUE)
	l->rows(120);
	l->cols(50);
	l->set_col_width(50,-1);
	l->feature(bit.bor(
			flvw.FLVF_HEADERS, 
			flvw.FLVF_DIVIDERS, 
			flvw.FLVF_MULTI_SELECT,
			flvw.FLVF_ROW_SELECT
		));
	--l->feature_remove(flvw.FLVF_HEADERS)
	--l->feature_add(flvw.FLVF_ROW_SELECT)

	l.global_style:resizable(true);
	l.global_style:width(50);
	l.global_style:height(22);

	l.row_style:get(-1):align(fltk.FL_ALIGN_CLIP);
	l.col_style:get(-1):align(fltk.FL_ALIGN_CLIP);

	w->show_main();
	fltk.Fl:run();
end

main()