--
-- exercisetablerow -- Exercise all aspects of the Fl_Table_Row widget
--

function iif(cond, ifTrue, ifFalse)
	if cond then
		return ifTrue
	else
		return ifFalse
	end
end

-- Simple demonstration class to derive from Fl_Table_Row

local DemoTable = {
	cell_bgcolor = fltk.FL_WHITE,
	cell_fgcolor = fltk.FL_BLACK,
}

DemoTable.__index = DemoTable

function DemoTable:new(x,y,w,h,l)

   -- create a table and make it an 'instance' of CustomWidget
   local t = {}
   setmetatable(t, DemoTable)

   -- create a Lua__Widget object, and make the table inherit from it
   local w = fltk.Lua__Fl_Table_Row:new(x,y,w,h,l)
   tolua.setpeer(w, t) -- use 'tolua.inherit' on lua 5.0

   -- 'w' will be the lua object where the virtual methods will be looked up
   w:tolua__set_instance(w)

   return w -- return 't' on lua 5.0 with tolua.inherit
end

-- Handle drawing all cells in table

function DemoTable:draw_cell(context, R, C, X, Y, W, H)
	--print(context, R, C, X, Y, W, H, string.format('%d:%d', R, C))
	if context == self.CONTEXT_STARTPAGE then
		fltk.fl_font(fltk.FL_HELVETICA, 16)
		return
	elseif context == self.CONTEXT_COL_HEADER then
	    fltk.fl_push_clip(X, Y, W, H);
	    do
		fltk.fl_draw_box(fltk.FL_THIN_UP_BOX, X, Y, W, H, self:col_header_color());
		fltk.fl_color(fltk.FL_BLACK);
		fltk.fl_draw(string.format('%d:%d', R, C), X, Y, W, H, fltk.FL_ALIGN_CENTER);
	    end
	    fltk.fl_pop_clip();
	    return
	elseif context == self.CONTEXT_ROW_HEADER then
	    fltk.fl_push_clip(X, Y, W, H);
	    do
		fltk.fl_draw_box(fltk.FL_THIN_UP_BOX, X, Y, W, H, self:row_header_color());
		fltk.fl_color(fltk.FL_BLACK);
		fltk.fl_draw(string.format('%d:%d', R, C), X, Y, W, H, fltk.FL_ALIGN_CENTER);
	    end
	    fltk.fl_pop_clip();
	    return;
	elseif context == self.CONTEXT_CELL then
	    fltk.fl_push_clip(X, Y, W, H);
	    do
	        -- BG COLOR
		fltk.fl_color( iif(self:row_selected(R) ~= 0, self:selection_color(), self.cell_bgcolor));
		fltk.fl_rectf(X, Y, W, H);

		-- TEXT
		fltk.fl_color(self.cell_fgcolor);
		fltk.fl_draw(string.format('%d:%d', R, C), X, Y, W, H, fltk.FL_ALIGN_CENTER);

		-- BORDER
		fltk.fl_color(self:color()); 
		fltk.fl_rect(X, Y, W, H);
	    end
	    fltk.fl_pop_clip();
	    return;
	elseif context == self.CONTEXT_TABLE then
		print("TABLE CONTEXT CALLED\n");
		return
	elseif context == self.CONTEXT_ENDPAGE then
	elseif context == self.CONTEXT_RC_RESIZE then
	elseif context == self.CONTEXT_NONE then
	end
end

-- Callback whenever someone clicks on different parts of the table
function DemoTable:event_callback(w, dt)
    dt->event_callback2();
end

function DemoTable:event_callback2()
    R = callback_row()
    C = callback_col()
    context = callback_context()
    print(string.format("'%s' callback: ", iif(label(), label(), "?")));
    print(string.format("Row=%d Col=%d Context=%d Event=%d InteractiveResize? %d\n",
	    R, C, context, fltk.Fl:event(), is_interactive_resize()));
end

-- GLOBAL TABLE WIDGET
G_table = false

function setrows_cb(w, fin)
    rows = tonumber(fin->value());
    if ( rows < 0 ) then rows = 0; end
    G_table->rows(rows);
end

function setcols_cb(w, fin)
    cols = tonumber(fin->value());
    if ( cols < 0 ) then cols = 0; end
    G_table->cols(cols);
end

function setrowheader_cb(w, check)
    G_table->row_header(check->value());
end

function setcolheader_cb(w, check)
    G_table->col_header(check->value());
end

function setrowresize_cb(w, check)
    G_table->row_resize(check->value());
end

function setcolresize_cb(w, check)
    G_table->col_resize(check->value());
end

function setpositionrow_cb(w, fin)
    toprow = tonumber(fin->value())
    if ( toprow < 0 or toprow >= G_table->rows() ) then
        fltk.fl_alert("Must be in range 0 thru #rows"); 
    else
        G_table->row_position(toprow);
	end
end

function setpositioncol_cb(w, fin)
    leftcol = tonumber(fin->value())
    if ( leftcol < 0 or leftcol >= G_table->cols() ) then
        fltk.fl_alert("Must be in range 0 thru #cols");
    else
        G_table->col_position(leftcol);
	end
end

function setrowheaderwidth_cb(w, fin)
    val = tonumber(fin->value())
    if ( val < 1 ) then val = 1; fin->value("1"); end
    G_table->row_header_width(val);
end

function setcolheaderheight_cb(w, fin)
    val = tonumber(fin->value())
    if ( val < 1 ) then val = 1; fin->value("1"); end
    G_table->col_header_height(val);
end

function setrowheadercolor_cb(w, fin)
    val = tonumber(fin->value())
    if ( val < 0 ) then fltk.fl_alert("Must be a color >0");
    else G_table->row_header_color(val); end
end

function setcolheadercolor_cb(w, fin)
    val = tonumber(fin->value());
    if ( val < 0 ) then fltk.fl_alert("Must be a color >0");
    else G_table->col_header_color(val); end
end

function setrowheightall_cb(w, fin)
    val = tonumber(fin->value())
    if ( val < 0 ) then val = 0; fin->value("0"); end
    G_table->row_height_all(val);
end

function setcolwidthall_cb(w, fin)
    val = tonumber(fin->value())
    if ( val < 0 ) then val = 0; fin->value("0"); end
    G_table->col_width_all(val);
end

function settablecolor_cb(w, fin)
    val = tonumber(fin->value())
    if ( val < 0 ) then fltk.fl_alert("Must be a color >0")
    else G_table->color(val) end
    G_table->redraw();
end

function setcellfgcolor_cb(w, fin)
    val = tonumber(fin->value());
    if ( val < 0 ) then fltk.fl_alert("Must be a color >0")
    else G_table->SetCellFGColor(val) end
    G_table->redraw();
end

function setcellbgcolor_cb(w, fin)
    val = tonumber(fin->value());
    if ( val < 0 ) then fltk.fl_alert("Must be a color >0")
    else G_table->SetCellBGColor(val); end
    G_table->redraw();
end

function tablebox_choice_cb(w, data)
    G_table->table_box(data);
    G_table->redraw();
end

function widgetbox_choice_cb(w, data)
    G_table->box(data);
    G_table->resize(G_table->x(), G_table->y(), G_table->w(), G_table->h());
end

function type_choice_cb(w, data)
    G_table->type(data);
end

tablebox_choices = {
  {"No Box",         0, tablebox_choice_cb, FL_NO_BOX },
  {"Flat Box",       0, tablebox_choice_cb, FL_FLAT_BOX },
  {"Up Box",         0, tablebox_choice_cb, FL_UP_BOX },
  {"Down Box",       0, tablebox_choice_cb, FL_DOWN_BOX },
  {"Up Frame",       0, tablebox_choice_cb, FL_UP_FRAME },
  {"Down Frame",     0, tablebox_choice_cb, FL_DOWN_FRAME },
  {"Thin Up Box",    0, tablebox_choice_cb, FL_THIN_UP_BOX },
  {"Thin Down Box",  0, tablebox_choice_cb, FL_THIN_DOWN_BOX },
  {"Thin Up Frame",  0, tablebox_choice_cb, FL_THIN_UP_FRAME },
  {"Thin Down Frame",0, tablebox_choice_cb, FL_THIN_DOWN_FRAME },
  {"Engraved Box",   0, tablebox_choice_cb, FL_ENGRAVED_BOX },
  {"Embossed Box",   0, tablebox_choice_cb, FL_EMBOSSED_BOX },
  {"Engraved Frame", 0, tablebox_choice_cb, FL_ENGRAVED_FRAME },
  {"Embossed Frame", 0, tablebox_choice_cb, FL_EMBOSSED_FRAME },
  {"Border Box",     0, tablebox_choice_cb, FL_BORDER_BOX },
  {"Shadow Box",     0, tablebox_choice_cb, FL_SHADOW_BOX },
  {"Border Frame",   0, tablebox_choice_cb, FL_BORDER_FRAME },
  {0}
};

widgetbox_choices = {
  {"No Box",         0, widgetbox_choice_cb, FL_NO_BOX },
--{"Flat Box",       0, widgetbox_choice_cb, FL_FLAT_BOX },
--{"Up Box",         0, widgetbox_choice_cb, FL_UP_BOX },
--{"Down Box",       0, widgetbox_choice_cb, FL_DOWN_BOX },
  {"Up Frame",       0, widgetbox_choice_cb, FL_UP_FRAME },
  {"Down Frame",     0, widgetbox_choice_cb, FL_DOWN_FRAME },
--{"Thin Up Box",    0, widgetbox_choice_cb, FL_THIN_UP_BOX },
--{"Thin Down Box",  0, widgetbox_choice_cb, FL_THIN_DOWN_BOX },
  {"Thin Up Frame",  0, widgetbox_choice_cb, FL_THIN_UP_FRAME },
  {"Thin Down Frame",0, widgetbox_choice_cb, FL_THIN_DOWN_FRAME },
--{"Engraved Box",   0, widgetbox_choice_cb, FL_ENGRAVED_BOX },
--{"Embossed Box",   0, widgetbox_choice_cb, FL_EMBOSSED_BOX },
  {"Engraved Frame", 0, widgetbox_choice_cb, FL_ENGRAVED_FRAME },
  {"Embossed Frame", 0, widgetbox_choice_cb, FL_EMBOSSED_FRAME },
--{"Border Box",     0, widgetbox_choice_cb, FL_BORDER_BOX },
--{"Shadow Box",     0, widgetbox_choice_cb, FL_SHADOW_BOX },
  {"Border Frame",   0, widgetbox_choice_cb, FL_BORDER_FRAME },
  {0}
};

type_choices = {
  {"SelectNone",         0, type_choice_cb, fltk.Fl_Table_Row.SELECT_NONE },
  {"SelectSingle",       0, type_choice_cb, fltk.Fl_Table_Row.SELECT_SINGLE },
  {"SelectMulti",        0, type_choice_cb, fltk.Fl_Table_Row.SELECT_MULTI },
  {0}
};

function main()
    local win = fltk.Fl_Window(900, 730);

    G_table = DemoTable:new(20, 20, 860, 460, "Demo");
    G_table->selection_color(fltk.FL_YELLOW);
    G_table->when(bit.bor(fltk.FL_WHEN_RELEASE, fltk.FL_WHEN_CHANGED));
    G_table->table_box(fltk.FL_NO_BOX);
    G_table->col_resize_min(4);
    G_table->row_resize_min(4);

    -- ROWS
    G_table->row_header(1);
    G_table->row_header_width(60);
    G_table->row_resize(1);
    G_table->rows(500);
    G_table->row_height_all(20);

    -- COLS
    G_table->cols(500);
    G_table->col_header(1);
    G_table->col_header_height(25);
    G_table->col_resize(1);
    G_table->col_width_all(80);

    -- Add children to window
    win:begin();

    -- ROW
    local setrows = fltk.Fl_Input:new(150, 500, 120, 25, "Rows");
    setrows:labelsize(12);
    setrows:value(G_table->rows());
    setrows:callback2ww(setrows_cb, setrows);
    setrows:when(fltk.FL_WHEN_RELEASE);

    local rowheightall = fltk.Fl_Input:new(400, 500, 120, 25, "Row Height");
    rowheightall:labelsize(12);
    rowheightall:value(G_table->row_height(0));
    rowheightall:callback2ww(setrowheightall_cb, rowheightall);
    rowheightall:when(fltk.FL_WHEN_RELEASE);

    local positionrow = fltk.Fl_Input:new(650, 500, 120, 25, "Row Position");
    positionrow:labelsize(12);
    positionrow:value("1");
    positionrow:callback2ww(setpositionrow_cb, positionrow);
    positionrow:when(fltk.FL_WHEN_RELEASE);

    -- COL
    local setcols = fltk.Fl_Input:new (150, 530, 120, 25, "Cols");
    setcols:labelsize(12);
    setcols:value(G_table->cols());
    setcols:callback2ww(setcols_cb, setcols);
    setcols:when(fltk.FL_WHEN_RELEASE);

    local colwidthall = fltk.Fl_Input:new (400, 530, 120, 25, "Col Width");
    colwidthall:labelsize(12);
    colwidthall:value(G_table->col_width(0));
    colwidthall:callback2ww(setcolwidthall_cb, colwidthall);
    colwidthall:when(fltk.FL_WHEN_RELEASE);

    local positioncol = fltk.Fl_Input:new (650, 530, 120, 25, "Col Position");
    positioncol:labelsize(12);
    positioncol:value("1");
    positioncol:callback2ww(setpositioncol_cb, positioncol);
    positioncol:when(fltk.FL_WHEN_RELEASE);

    -- ROW HEADER
    local rowheaderwidth = fltk.Fl_Input:new (150, 570, 120, 25, "Row Header Width");
    rowheaderwidth:labelsize(12);
    rowheaderwidth:value(G_table->row_header_width());
    rowheaderwidth:callback2ww(setrowheaderwidth_cb, rowheaderwidth);
    rowheaderwidth:when(fltk.FL_WHEN_RELEASE);

    local rowheadercolor = fltk.Fl_Input:new (400, 570, 120, 25, "Row Header Color");
    rowheadercolor:labelsize(12);
    rowheadercolor:value(G_table->row_header_color());
    rowheadercolor:callback2ww(setrowheadercolor_cb, rowheadercolor);
    rowheadercolor:when(fltk.FL_WHEN_RELEASE);

    local rowheader = fltk.Fl_Check_Button:new (550, 570, 120, 25, "Row Headers?");
    rowheader:labelsize(12);
    rowheader:callback2ww(setrowheader_cb, rowheader);
    rowheader:value(iif(G_table->row_header(), 1, 0));

    local rowresize = fltk.Fl_Check_Button:new (700, 570, 120, 25, "Row Resize?");
    rowresize:labelsize(12);
    rowresize:callback2ww(setrowresize_cb, rowresize);
    rowresize:value(iif(G_table->row_resize(), 1, 0));

    -- COL HEADER
    local colheaderheight = fltk.Fl_Input:new (150, 600, 120, 25, "Col Header Height");
    colheaderheight:labelsize(12);
    colheaderheight:value(G_table->col_header_height());
    colheaderheight:callback2ww(setcolheaderheight_cb, colheaderheight);
    colheaderheight:when(fltk.FL_WHEN_RELEASE);

    local colheadercolor = fltk.Fl_Input:new (400, 600, 120, 25, "Col Header Color");
    colheadercolor:labelsize(12);
    colheadercolor:value(G_table->col_header_color());
    colheadercolor:callback2ww(setcolheadercolor_cb, colheadercolor);
    colheadercolor:when(fltk.FL_WHEN_RELEASE);

    local colheader = fltk.Fl_Check_Button:new (550, 600, 120, 25, "Col Headers?");
    colheader:labelsize(12);
    colheader:callback2ww(setcolheader_cb, colheader);
    colheader:value(iif(G_table->col_header(), 1, 0));

    local colresize = fltk.Fl_Check_Button:new (700, 600, 120, 25, "Col Resize?");
    colresize:labelsize(12);
    colresize:callback2ww(setcolresize_cb, colresize);
    colresize:value(iif(G_table->col_resize(), 1, 0));

    local tablebox = fltk.Fl_Choice:new (150, 640, 120, 25, "Table Box");
    tablebox:labelsize(12);
    tablebox:textsize(12);
    --tablebox:menu(tablebox_choices);
    tablebox:value(0);

    local widgetbox = fltk.Fl_Choice:new (150, 670, 120, 25, "Widget Box");
    widgetbox:labelsize(12);
    widgetbox:textsize(12);
    --widgetbox:menu(widgetbox_choices);
    widgetbox:value(2);		-- down frame

    local tablecolor = fltk.Fl_Input:new (400, 640, 120, 25, "Table Color");
    tablecolor:labelsize(12);
    tablecolor:value(G_table->color());
    tablecolor:callback2ww(settablecolor_cb, tablecolor);
    tablecolor:when(fltk.FL_WHEN_RELEASE);

    local cellbgcolor = fltk.Fl_Input:new (400, 670, 120, 25, "Cell BG Color");
    cellbgcolor:labelsize(12);
    cellbgcolor:value(G_table.cell_bgcolor);
    cellbgcolor:callback2ww(setcellbgcolor_cb, cellbgcolor);
    cellbgcolor:when(fltk.FL_WHEN_RELEASE);

    local cellfgcolor = fltk.Fl_Input:new(400, 700, 120, 25, "Cell FG Color");
    cellfgcolor:labelsize(12);
    cellfgcolor:value(G_table.cell_fgcolor);
    cellfgcolor:callback2ww(setcellfgcolor_cb, cellfgcolor);
    cellfgcolor:when(fltk.FL_WHEN_RELEASE);

    local choice_type = fltk.Fl_Choice:new(650, 640, 120, 25, "Type");
    choice_type:labelsize(12);
    choice_type:textsize(12);
    --choice_type:menu(type_choices);
    choice_type:value(2);

    win:endd();
    win:resizable(G_table);
    win:show_main();

    fltk.Fl:run()
end

main()
