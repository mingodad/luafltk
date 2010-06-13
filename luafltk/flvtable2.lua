--	======================================================================
--	File:    testtable2.cxx
--	Program: testtable2
--	Version: 0.1.0
--	Started: 11/21/99
--
--	Copyright (C) 1999 Laurence Charlton
--
--	Description:
--	Example of using an Flv_Table with dynamic column widths.
--	This will also demonstrate mixed styling (dynamic and virtual)
--	======================================================================

--	Demonstrate Simplest Fl_List_Child

function iif(cond, ifTrue, ifFalse)
	if cond then
		return ifTrue
	else
		return ifFalse
	end
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
   w.working_style = flvw.Flv_Style()
   w.LW=-1

   return w -- return 't' on lua 5.0 with tolua.inherit
end

row_values = {
	{ "",									"",				"",					"Total",		"$213.23"	},
	{ "Name",							"Male",		"Phone",		"Meet",				"Due"	},
	{	"Smith, John", 			"Male", 	"555-1212", "05/14/1999", "$50.00" },
	{	"Jet, Joan", 				"Female", "234-1234", "12/22/1999", "$25.75" },
	{	"Frampton, Peter", 	"Male", 	"324-8723", "09/17/1999", "$35.22" },
	{	"Ozborne, Ozzy", 		"Male", 	"545-8273", "04/05/1999", "$84.72" },
	{	"Person, Test", 		"Male", 	"563-2938", "08/04/1999", "$38.83" },
	{	"Clairborne, Liz", 	"Female", "723-9382", "03/17/1999", "-$61.34" },
	{	"Curie , Madam", 		"Female", "234-7382", "02/23/1999", "$22.43" },
	{	"Benetar, Pat", 		"Female", "121-2837", "06/09/1999", "$14.18" },
	{	"Krull, Diane", 		"Female", "345-2384", "01/11/2000", "-$68.88" },
	{	"Simpson, Bart", 		"Male", 	"928-1342", "07/23/1999", "$72.32" },
}

function get_value( R, C )
	--print(R,C)
	if R < -2 then return '' end
	return row_values[R+2+1][C+1]
end

--	Note: This is so flexible, you don't *have* to use style
--	if you'd rather program the conditions...
function Flv_Table_Child:get_style( s, R, C )
	local st
	
	self:Flv_Table__get_style(s,R,C);					--	Get standard style
	if (R<0) then															--	Heading/Footing is bold
		s:font( s:font()+fltk.FL_BOLD)
	end
	if (R==-2)	then													--	Row footer exception
		s:background( fltk.FL_BLACK );						--	Black background
		s:foreground( fltk.FL_WHITE );						--	White text
		s:frame( fltk.FL_FLAT_BOX );							--	No box
		s:align(fltk.FL_ALIGN_RIGHT);						--	Right aligned
	end
	if (R>-1 and C>-1 and (R%2)==0 and C<4 ) then				--	Highlight every other row
		s:background( fltk.FL_GRAY_RAMP+21 )
	end
	st = get_value(R,C);
	if (st) then
		if (st:find("-$", 1, true)) then	--	Negative $ are RED
			s:border(flvw.FLVB_OUTER_ALL);						--	Nice dark box
			s:foreground(fltk.FL_RED);								--	Text in red
			s:background(215);									--	Pale yellow background
		end
	end
end

SZ= 5

function Flv_Table_Child:draw_cell( Offset, X, Y, W, H, R, C )
	local x, y, w, h

	self:get_style(self.working_style,R,C)
	self:Flv_Table__draw_cell(Offset,X,Y,W,H,R,C)

	--	Draw an X
	if (C==1 and R>-1) then
		if (get_value(R,C)=='Male') then
			fltk.fl_draw_symbol("@circle", X-Offset+(W-SZ)/2, Y+(H-SZ)/2, SZ,
											SZ, fltk.FL_GRAY_RAMP+16 )
		end
	else
			fltk.fl_draw(get_value(R,C), X-Offset, Y, W, H, self.working_style:align() );
	end
end

cw = {}	--	Column width
--	Another way would be to override handle for FL_SIZE.  We could also
--	spend a lot of time setting styles for the columns and returning
--	that, but since we're calculating it anyway, why bother.
function Flv_Table_Child:col_width( C )
	local scrollbar_width = iif(self:has_scrollbar() ~= 0, self:scrollbar_width(), 0)
	local W = self:w()- scrollbar_width-1
	local ww, t;

	--	Either always calculate or be sure to check that width
	--	hasn't changed.
	if (W != self.LW) then							--	Width change, recalculate
		cw[0] = (W*30)/100;		--	30		Name
		cw[1] = (W*15)/100;		--	10		Gender
		cw[2] = (W*20)/100;		--	 5%		Phone
		cw[3] = (W*20)/100;		--	15%		Date
		ww=0
		t=0
		while (t<4) do
			inc(ww, cw[t])
			inc(t)
		end
		cw[4] = W-ww-1;	 				--	~30% +/- previous rounding errors
		self.LW = W;
	end
	return cw[C];
end

function main()
	w = fltk.Fl_Double_Window( 432, 255, "Dynamic row size example" );
	l = Flv_Table_Child:new( 10, 10, 412, 235, "Current Appointments" );
	w->endd();

	w->resizable(l);
  --	row height (17) * rows (10) +
  --	row height headers (17+4) * number of headers (3) +
  --	Top/Bottom box margins (2)

	--	Comment/or uncomment any of these lines to see the result
	l->rows(10);
	l->cols(5);
	l->selection_color(fltk.FL_BLUE)
	l->has_scrollbar(fltk.FLVS_VERTICAL);
	l->feature(bit.bor(flvw.FLVF_ROW_ENDS, flvw.FLVF_ROW_SELECT));
	l.global_style:align(fltk.FL_ALIGN_LEFT);		--	Left alignment
	l.global_style:height(17);

	l.col_style:get(4):border_color(fltk.FL_BLACK);		--	Black line
	l.col_style:get(4):border(flvw.FLVB_LEFT);				--	On left of last column
	l.col_style:get(4):background(93);						--	Orange background? :)

	--	Have to align something differently! :)
	l.col_style:get(1):align(fltk.FL_ALIGN_CENTER);		--	Gender
	l.col_style:get(4):align(fltk.FL_ALIGN_RIGHT);		--	Amount

	--	We have a created 3 styles at this point, besides of course
	--	global_style, row_style, col_style, and the cell_style in our
	--	one row_style.
	w->endd();
	w->show_main();
	fltk.Fl:run();
end

main()
