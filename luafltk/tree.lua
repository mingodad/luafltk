treeButton = nil
treeGroup = nil

  L_folder_xpm = {
    "11 11 3 1",
    ".  c None",
    "x  c #d8d833",
    "@  c #808011",
    "...........",
    ".....@@@@..",
    "....@xxxx@.",
    "@@@@@xxxx@@",
    "@xxxxxxxxx@",
    "@xxxxxxxxx@",
    "@xxxxxxxxx@",
    "@xxxxxxxxx@",
    "@xxxxxxxxx@",
    "@xxxxxxxxx@",
    "@@@@@@@@@@@"
  }
  L_folderpixmap=fltk.Fl_Pixmap:NewFromStrTable(L_folder_xpm)
  tolua.takeownership(L_folderpixmap)

  L_document_xpm = {
    "11 11 3 1",
    ".  c None",
    "x  c #d8d8f8",
    "@  c #202060",
    ".@@@@@@@@@.",
    ".@xxxxxxx@.",
    ".@xxxxxxx@.",
    ".@xxxxxxx@.",
    ".@xxxxxxx@.",
    ".@xxxxxxx@.",
    ".@xxxxxxx@.",
    ".@xxxxxxx@.",
    ".@xxxxxxx@.",
    ".@xxxxxxx@.",
    ".@@@@@@@@@."
  }
  L_documentpixmap=fltk.Fl_Pixmap:NewFromStrTable(L_document_xpm)
  tolua.takeownership(L_documentpixmap)
  
function RebuildTree(tree)
  -- REBUILD THE TREE TO MAKE CURRENT "DEFAULT" PREFS TAKE EFFECT
  tree->clear()
  tree->add("Aaa")
  tree->add("Bbb")
  tree->add("Ccc")
  tree->add("Ddd")
  tree->add("Bbb/child-01")
  tree->add("Bbb/child-01/111")
  tree->add("Bbb/child-01/222")
  tree->add("Bbb/child-01/333")
  tree->add("Bbb/child-02")
  tree->add("Bbb/child-03")
  tree->add("Bbb/child-04")

  --// Assign an FLTK widget to one of the items
  local item = tree->find_item("Bbb/child-03")
  if item then
    if not treeButton then		--// only do this once at program startup
        tree->begin()
        treeButton = fltk.Fl_Button:new(1,1,140,1,"ccc button");     --// we control w() only
        treeButton->labelsize(10)
		tree->endd()
    end
    item->widget(treeButton)
  end
  
    --// Assign an FLTK group to one of the items with widgets
	item = tree->find_item("Bbb/child-04")
    if item then
      if not treeGroup then		--// only do this once at program startup
        tree->begin()
        treeGroup = fltk.Fl_Group:new(100,100,140,18) -- // build group.. tree handles position
        treeGroup->color(fltk.FL_WHITE)
        treeGroup->begin()
        local abut = fltk.Fl_Button:new(treeGroup->x()+0 ,treeGroup->y()+2,65,15,"D1")
        abut->labelsize(10)
        local bbut = fltk.Fl_Button:new(treeGroup->x()+75,treeGroup->y()+2,65,15,"D2")
        bbut->labelsize(10)
        treeGroup->endd()
        treeGroup->resizable(treeGroup)
        tree->endd()
      end
      item->widget(treeGroup)
    end

  --// Add an 'Ascending' node, and create it sorted
  tree->sortorder(fltk.FL_TREE_SORT_NONE);
  tree->add("Ascending")->close();
  tree->sortorder(fltk.FL_TREE_SORT_ASCENDING);
  tree->add("Ascending/Zzz");
  tree->add("Ascending/Xxx");
  tree->add("Ascending/Aaa");
  tree->add("Ascending/Bbb");
  tree->add("Ascending/Yyy");
  tree->add("Ascending/Ccc");
  
  --// Add a 'Descending' node, and create it sorted
  tree->sortorder(fltk.FL_TREE_SORT_NONE);
  tree->add("Descending")->close();
  tree->sortorder(fltk.FL_TREE_SORT_DESCENDING);
  tree->add("Descending/Zzz");
  tree->add("Descending/Xxx");
  tree->add("Descending/Aaa");
  tree->add("Descending/Bbb");
  tree->add("Descending/Yyy");
  tree->add("Descending/Ccc");
  
  
  
  if true then
    tree->usericon(L_folderpixmap);
	item = tree->find_item("Descending/Ccc")
    if item then item->usericon(L_documentpixmap) end
	item = tree->find_item("Descending/Aaa")
    if item then item->usericon(L_documentpixmap) end
	item = tree->find_item("Descending/Zzz")
    if item then item->usericon(L_documentpixmap) end
  else
    tree->usericon(0);
	item = tree->find_item("Bbb/bgb/111")
    if item then item->usericon(0) end
	item = tree->find_item("Bbb/bgb/222")
    if item then item->usericon(0) end
	item = tree->find_item("Bbb/bgb/333")
    if item then item->usericon(0) end
  end
  
  tree->redraw();
	
end

function cb_tree(tree, data)
	item = tree->item_clicked()
	--//item->select( item->is_selected() ? 0 : 1);
	--//tree->redraw();
	if item then
		print(string.format("TREE CALLBACK: label='%s' userdata=%d\n",
				item->label(),
				data
			))
	end
end


window = fltk.Fl_Double_Window(580, 450, "test-Fl_Tree")
tree = fltk.Fl_Tree:new(15, 15, 550, 390)
tree->box(fltk.FL_DOWN_BOX)
tree->color(55)
tree->selection_color(fltk.FL_BACKGROUND_COLOR)
tree->labeltype(fltk.FL_NORMAL_LABEL)
tree->labelfont(0)
tree->labelsize(20)
tree->labelcolor(fltk.FL_FOREGROUND_COLOR)
tree->callback2wl(cb_tree, 1234)
tree->align(fltk.FL_ALIGN_TOP)
tree->when(fltk.FL_WHEN_RELEASE)
tree->endd()
RebuildTree(tree)
window->endd()

window->resizable(tree)
window->show_main()
fltk.Fl:run()