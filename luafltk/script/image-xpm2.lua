xpm_box=fltk.Fl_Box:new(30,20,100,300)
xpm_box:label('dad')
xpm_box_label=fltk.Fl_Box:new(130,20,300,300)
xpm_box_label:align(fltk.FL_ALIGN_WRAP)
xpm_box_label:label("The image data is stored within a variable in the script. It's exported to a temp file, which is then loaded with Fl_XPM_Image()")
-- Direct use of pixmap data (Fl_Pixmap) added in murgaLua 0.6; see image-xpm3.lua

xpm_file=[[
/* XPM */
static char *potato48_xpm[] = {
"48 48 16 1",
"0	c #000100",
"1	c #383937",
"2	c #616360",
"3	c #534800",
"4	c #9B6800",
"5	c #D79300",
"6	c #FECC69",
"7	c #989A00",
"8	c #00699A",
"9	c #00ACF3",
"A	c #839D9A",
"B	c #FEC489",
"C	c #A9FEFE",
"D	c #CDCFCC",
"E	c #FDFEFB",
" 	c None",
"                               00000000         ",
"                            000444B6B60000      ",
"                      000000044444466B6B600     ",
"                     0334444000465556565BB00    ",
"                 000000004445450454555555660    ",
"                00EEEEEEE05565456565655555600   ",
"              000EEEEEEEEE055444444545555B560   ",
"             00EEEEEEEEEEED054456545654555660   ",
"            00EECCCCEEEEEEE144444554555545560   ",
"            0DC99999CEEEEEEE044444555455655B0   ",
"           00E9999999EEEEEEE04444444444555560   ",
"           0EE99918ECEEEEEEE054444456444655B6   ",
"           0E99101EEE9EEEEEE045455454544555B5   ",
"           0E990001E899CEEE0556203234556555B5   ",
"      0    0E98000008999EEE1421DDEEED05555B53   ",
"     00   00E99010001999EEA21DEEEEEEEE0565652   ",
"    000   01E99C00008999EE01EEEEEEEEEED14555    ",
"    0000 000EE99C899999EE01EEEEEEEEEEEED5550    ",
"   000E004400E99999999EE20EE9999EEEEEEEE3540    ",
"   020E004400EEE9999EEE12DE999999EEEEEEE0540    ",
"   020EE044400DEEEEEEA050E9999899EEEEEEE0500    ",
"   0E0EE004430000A0023570E99808EEEEEEEEE230     ",
"   0E00EE044431111135550EE9A00EEECEEEEEE30      ",
"   02E0EE004645465545550E999111E1899EEED00      ",
"   02E0EEE00454545557500E99100000899EEE000      ",
"   02EE0EEE0045454655500EE9C00100999CED0        ",
"   00EEE0EEE0005554555000E99C001899ECE0         ",
"  000DEEE0EEEE00655455600EC99999999CE00         ",
"  0400EEE000EEE00055454000EC99999ECE00          ",
"  04000EEEE0EEEEE00B5555000EECCCEE000           ",
" 004400EEEE0EEEEEE00055550000EEE0001            ",
" 0444500EEEEE0EEEEEE000465570000040             ",
" 04444400EEEEEE0000EEE0001457555410             ",
" 0445544400EEEEEEE0EEEEE0000002200              ",
" 04454554000EEEEEEEE00EEEEEE0000000000          ",
" 0446545550000EEEEEEEE001EEEEEEEEE001           ",
" 034455555550000EEEEEEEEEE0000000000            ",
" 0445565556550000000EEEEEEEED20000              ",
" 044555555555545000000000000000                 ",
" 0444565655565556555554241                      ",
" 00444454545554545554430                        ",
"  00444555555557544243                          ",
"   004444555554437312                           ",
"    00424443444221                              ",
"      013434311                                 ",
"                                                ",
"                                                ",
"                                                "
};
]]

xpm_tempfile='./' .. os.tmpname()
xpm_write=io.open(xpm_tempfile,"w")
if xpm_write then
xpm_write:write(xpm_file)
xpm_write:close()
xpm_data=fltk.Fl_XPM_Image(xpm_tempfile)
os.remove(xpm_tempfile)
xpm_copy=xpm_data:copy() -- make a copy for deimage
xpm_copy:inactive() -- fade the copy
xpm_box:image(xpm_data) -- apply the original to activated state
xpm_box:deimage(xpm_copy) -- apply the copy to deactivated state
end
deimage_button=fltk.Fl_Toggle_Button:new(130,240,300,30,"toggle deimage")
deimage_button:callback(function(deimg_cb)
if deimage_button:value() == 1 then
	xpm_box:deactivate()
else
	xpm_box:activate()
end
xpm_box:redraw()
end
)
xpm_box:tooltip("my_image:count() = "..xpm_data:count())

