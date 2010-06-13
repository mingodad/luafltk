-- fl_file_chooser (function)
-- fltk.fl_file_chooser(title,filename_filter,start_path,relative)
-- "relative" is a toggle. Non-zero means the filename returned will be a relative path, and zero returns absolute path. 

open_uri_output=fltk.Fl_Input:new(10,40,350,30,"@<- URL to open")
open_uri_output:align(fltk.FL_ALIGN_RIGHT)
open_uri_button=fltk.Fl_Return_Button:new(10,10,200,30,"fltk.fl_open_uri")
open_uri_button:callback(function(fc_cb)
    fltk.fl_open_uri(open_uri_output:value())
end
)
