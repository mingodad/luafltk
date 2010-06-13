

ts=48 -- tile size
tc=6  -- number of tiles in one line
fr=10 -- frame size

function move_tile(t)
  local my_x,my_y,movex,movey=t:x(),t:y()
  -- tile must be adjacent to the missing piece
  if (my_x == tile[hidden]:x() and math.abs(my_y-tile[hidden]:y()) == ts)
  or (my_y == tile[hidden]:y() and math.abs(my_x-tile[hidden]:x()) == ts)
  then
    movex=tile[hidden]:x()
    movey=tile[hidden]:y()
    tile[hidden]:position(my_x,my_y)
    t:position(movex,movey)
    demo_widget:redraw()
  end
end

-- array of tiles, top left to right, then move down
tile={}
-- allow space for the frame
row=fr; col=fr
for i=0,tc*tc-1 do
  tile[i]=fltk.Fl_Button:new(col,row,ts,ts)
  tile[i]:callback(move_tile)
  tile[i]:label(i+1) -- simple numbers could be replaced by images
  -- next piece is ts pixels to the right
  col=col+ts
  -- start the next row
  if col == ts*tc+fr then col=fr;row=row+ts end
end

-- turn a random tile into the missing piece
math.randomseed(os.time())
hidden=math.random(0,24)
tile[hidden]:label("")
tile[hidden]:box(fltk.FL_DOWN_BOX)

-- next step would be to jumble the tiles, but I haven't worked that out.
