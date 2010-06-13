#include <FL/Fl_Widget.H>
#include <FL/Fl_Help_View.H>
#include <FL/Fl_Menu_.H>
#include <FL/Fl_Menu_Item.H>
#include <FL/Fl_Pixmap.H>
#include <FL/Fl_Browser.H>
#include <tolua++.h>

typedef int lua_Function;
typedef int lua_Object;

void fl_message_lua(const char *msg);
void fl_alert_lua(const char *msg);
int fl_ask_lua(const char *msg);
void Fl_End();

#define MY_PTR_STR(ptr, funcName)\
	char my_ptr_str[64];\
	snprintf(my_ptr_str, sizeof(my_ptr_str), "%p%s", ptr, funcName);\

int lua_set_cptr_luafunction(lua_State * __S__, char *key, int luaFunctionIndex);
int lua_delete_cptr_luafunction(lua_State * __S__, char *key);
int lua_get_cptr_luafunction(lua_State * __S__, char *key);

#define CALLBACK_PTRSTR(w) MY_PTR_STR(w, "callback")
void set_fltk_widget_callback(Fl_Widget *ctrl, lua_State* L, lua_Function luaFunc, lua_Object data=0);
/*
void set_fltk_widget_callback(Fl_Widget *ctrl, lua_State* L, lua_Function luaFunc);
void set_fltk_widget_callback2wl(Fl_Widget *ctrl, lua_State* L, lua_Function luaFunc, long num);
void set_fltk_widget_callback2ww(Fl_Widget *ctrl, lua_State* L, lua_Function luaFunc, Fl_Widget *w);
*/

#define LINK_PTRSTR(w) MY_PTR_STR(w, "link")
void set_fltk_help_view_link(Fl_Help_View *ctrl, lua_State* L, lua_Function luaFunc);

void set_fltk_menu_item_callback(Fl_Menu_Item *w, lua_State* L, lua_Function luaFunc, lua_Object data=0);

int set_fltk_fl_add_handler(lua_State* L, lua_Function luaFunc);
void fltk_fl_remove_handler(lua_State* L, int ref);

void set_fltk_fl_widget_user_handler(Fl_Group *w, lua_State* L, lua_Function luaFunc);

int set_fltk_fl_add_idle(lua_State* L, lua_Function luaFunc, lua_Object obj=0);
void fltk_fl_remove_idle(lua_State* L, int ref);

int set_fltk_fl_add_timeout(lua_State* L, double t, lua_Function luaFunc, lua_Object obj=0);
void set_fltk_fl_repeat_timeout(lua_State* L, double t, int ref);
void fltk_fl_remove_timeout(lua_State* L, int ref);

int fltk_Fl_get_color_rgb(lua_State* tolua_S);

Fl_Pixmap* new_fltk_Fl_Pixmap(lua_State* L, lua_Object tbl);

void fltk_Fl_Window_show(Fl_Window *win, lua_State* L);

int fltk_fl_add_focus_changing_handler(lua_State* L, lua_Function luaFunc);
void fltk_fl_remove_focus_changing_handler(lua_State* L);

void fltk_Fl_Browser_set_column_widths(Fl_Browser* brw, lua_State* L, lua_Object tbl);
lua_Object fltk_Fl_Browser_get_column_widths(Fl_Browser* brw, lua_State* L);

void fltk_Fl_Window_load_icon(Fl_Window* win, char *id);

int fltk_fl_menu_item_add(Fl_Menu_Item* self, lua_State* L, const char *label,
		lua_Object shortcut, lua_Function luaFunc, lua_Object data, int flags);

int fltk_fl_menu_item_insert(Fl_Menu_Item* self, lua_State* L, int index, const char *label,
		lua_Object shortcut, lua_Function luaFunc, lua_Object data, int flags);

int fltk_fl_menu_add(Fl_Menu_* self, lua_State* L, const char *label,
		lua_Object shortcut = 0, lua_Function luaFunc = 0, lua_Object data = 0, int flags = 0);

int fltk_fl_menu_insert(Fl_Menu_* self, lua_State* L, int index, const char *label,
		lua_Object shortcut, lua_Function luaFunc, lua_Object data, int flags);
