#include "FL/Fl.H"
#include "FL/Fl_Group.H"
#include "FL/fl_ask.H"
#include "fl_lua_misc.h"

void fl_message_lua(const char *msg)
{
  fl_message("%s", msg);
}

void fl_alert_lua(const char *msg)
{
  fl_alert("%s", msg);
}

int fl_ask_lua(const char *msg)
{
  return fl_ask("%s", msg);
}

void Fl_End(){
	Fl_Group::current()->end();
}

int lua_set_cptr_luafunction(lua_State * __S__, char *key, int luaFunctionIndex) {
	lua_pushstring(__S__, key); /* push the registry key */
	lua_pushvalue(__S__, luaFunctionIndex);   /* push lua function index*/
	/* registry[&ptr] = luaFunctionIndex */
    lua_settable(__S__, LUA_REGISTRYINDEX);
    return 0;
}

int lua_delete_cptr_luafunction(lua_State * __S__, char *key) {
	lua_pushstring(__S__, key); /* push the registry key */
	lua_pushnil(__S__);   /* push nil to delete the data */
	lua_settable(__S__, LUA_REGISTRYINDEX);
    return 0;
}

int lua_get_cptr_luafunction(lua_State * __S__, char *key) {
	lua_pushstring(__S__, key); /* push the registry key */
	//get the entry for this object pointer
	lua_gettable(__S__, LUA_REGISTRYINDEX);  /* retrieve value */

	if (!lua_isfunction(__S__, -1)) {
		return -1;
	}
  return 0;
}

static void lua_fltk_widget_callback(Fl_Widget * w, void *data)
{
  CALLBACK_PTRSTR(w);
  lua_State* L = (lua_State*)Fl::user_data;
  int savedTop = lua_gettop(L);
  lua_checkstack(L, 20);
  if(lua_get_cptr_luafunction(L, my_ptr_str) == 0) {
    tolua_pushusertype(L, w, w->classId());
    if(data) lua_rawgeti(L, LUA_REGISTRYINDEX, (int)data);
    else lua_pushnil(L);
	lua_call(L, 2, 0);
  }
  lua_settop(L, savedTop);
}

void set_fltk_widget_callback(Fl_Widget *w, lua_State* L, lua_Function luaFunc,
		lua_Object data){
	int ref_data;
	CALLBACK_PTRSTR(w);
	lua_set_cptr_luafunction(L, my_ptr_str, luaFunc);
	int old_data = (int)w->user_data();
	if(old_data) luaL_unref(L, LUA_REGISTRYINDEX, old_data);
	if(lua_isnil(L, data)) ref_data = 0;
	else ref_data = luaL_ref(L, LUA_REGISTRYINDEX);
	w->callback(&lua_fltk_widget_callback, (void*)ref_data);
}

/*
static void lua_fltk_widget_callback(Fl_Widget * w)
{
  CALLBACK_PTRSTR(w);
  lua_State* L = (lua_State*)Fl::user_data;
  int savedTop = lua_gettop(L);
  lua_checkstack(L, 20);
  if(lua_get_cptr_luafunction(L, my_ptr_str) == 0) {
    tolua_pushusertype(L, w, w->classId());
	lua_call(L, 1, 0);
  }
  lua_settop(L, savedTop);
}

void set_fltk_widget_callback(Fl_Widget *w, lua_State* L, lua_Function luaFunc)
{
	CALLBACK_PTRSTR(w);
	lua_set_cptr_luafunction(L, my_ptr_str, luaFunc);
	w->callback(&lua_fltk_widget_callback);
}

static void lua_fltk_widget_callback2wl(Fl_Widget * w, long ln)
{
  CALLBACK_PTRSTR(w);
  lua_State* L = (lua_State*)Fl::user_data;
  int savedTop = lua_gettop(L);
  lua_checkstack(L, 20);
  if(lua_get_cptr_luafunction(L, my_ptr_str) == 0) {
    tolua_pushusertype(L, w, w->classId());
    tolua_pushnumber(L, ln);
	lua_call(L, 2, 0);
  }
  lua_settop(L, savedTop);
}

void set_fltk_widget_callback2wl(Fl_Widget *w, lua_State* L, lua_Function luaFunc, long num)
{
	CALLBACK_PTRSTR(w);
	lua_set_cptr_luafunction(L, my_ptr_str, luaFunc);
	w->callback(&lua_fltk_widget_callback2wl, num);
}

static void lua_fltk_widget_callback2ww(Fl_Widget * w, void *p)
{
  CALLBACK_PTRSTR(w);
  lua_State* L = (lua_State*)Fl::user_data;
  int savedTop = lua_gettop(L);
  lua_checkstack(L, 20);
  if(lua_get_cptr_luafunction(L, my_ptr_str) == 0) {
    tolua_pushusertype(L, w, w->classId());
    tolua_pushusertype(L, p, ((Fl_Widget *)p)->classId());
	lua_call(L, 2, 0);
  }
  lua_settop(L, savedTop);
}

void set_fltk_widget_callback2ww(Fl_Widget *w, lua_State* L, lua_Function luaFunc, Fl_Widget *w2)
{
	CALLBACK_PTRSTR(w);
	lua_set_cptr_luafunction(L, my_ptr_str, luaFunc);
	w->callback(&lua_fltk_widget_callback2ww, w2);
}
*/

static const char* lua_fltk_help_view_link(Fl_Widget * w, const char *href)
{
  LINK_PTRSTR(w);
  lua_State* L = (lua_State*)Fl::user_data;
  int savedTop = lua_gettop(L);
  if(lua_get_cptr_luafunction(L, my_ptr_str) == 0) {
    tolua_pushusertype(L, w, w->classId());
	lua_pushstring(L, href);
	lua_call(L, 2, 1);
	//DAD come back here !!!
	//returning a stack string without copy/reference
	return lua_tostring(L, -1);
  }
  lua_settop(L, savedTop);
  return href;
}

void set_fltk_help_view_link(Fl_Help_View *w, lua_State* L, lua_Function luaFunc)
{
	LINK_PTRSTR(w);
	lua_set_cptr_luafunction(L, my_ptr_str, luaFunc);
	w->link(&lua_fltk_help_view_link);
}

static int lua_fltk_widget_user_handle(Fl_Widget *w, int event)
{
  LINK_PTRSTR(w);
  lua_State* L = (lua_State*)Fl::user_data;
  int savedTop = lua_gettop(L);
  if(lua_get_cptr_luafunction(L, my_ptr_str) == 0) {
    tolua_pushusertype(L, w, w->classId());
	lua_pushnumber(L, event);
	lua_call(L, 2, 1);
	return lua_tointeger(L, -1);
  }
  lua_settop(L, savedTop);
  return 0;
}

void set_fltk_fl_widget_user_handler(Fl_Group *w,lua_State* L, lua_Function luaFunc){
	LINK_PTRSTR(w);
	lua_set_cptr_luafunction(L, my_ptr_str, luaFunc);
	w->user_handler(&lua_fltk_widget_user_handle);
}

static void lua_fltk_fl_callback_with_ref(void * udata)
{
  lua_State* L = (lua_State*)Fl::user_data;
  int savedTop = lua_gettop(L);
  lua_rawgeti(L, LUA_REGISTRYINDEX, (int)udata);
  if(lua_isfunction(L, -1)) {
	lua_call(L, 0, 0);
  }
  lua_settop(L, savedTop);
}

static int fltk_global_event_handler_ref = 0;

static int fltk_global_event_handler(int ev)
{
  lua_State* L = (lua_State*)Fl::user_data;
  int result = 0;
  int oldtop = lua_gettop(L);

  lua_rawgeti(L, LUA_REGISTRYINDEX, fltk_global_event_handler_ref);
  if (lua_isfunction(L, -1)){
  	lua_pushnumber(L, (double)ev);
  	lua_call(L, 1, 1);
  	result = (int)lua_tonumber(L, -1);
  }
  lua_settop(L, oldtop);
  return result;
}

int set_fltk_fl_add_handler(lua_State* L, lua_Function luaFunc)
{
  if (!fltk_global_event_handler_ref)
  {
	lua_pushvalue(L, luaFunc);
	fltk_global_event_handler_ref = luaL_ref(L, LUA_REGISTRYINDEX);
	Fl::add_handler(&fltk_global_event_handler);
	return 1;
  }
  return 0;
}

void fltk_fl_remove_handler(lua_State* L, int ref)
{
	if (fltk_global_event_handler_ref){
		luaL_unref(L, LUA_REGISTRYINDEX, fltk_global_event_handler_ref);
		fltk_global_event_handler_ref = 0;
  		Fl::remove_handler(&fltk_global_event_handler);
	}
}

static void lua_fltk_fl_idle(void * udata)
{
  lua_State* L = (lua_State*)Fl::user_data;
  int savedTop = lua_gettop(L);
  lua_checkstack(L, 20);
  lua_rawgeti(L, LUA_REGISTRYINDEX, (int)udata);
  if(lua_istable(L, -1)) {
	lua_rawgeti(L, -1, 1); //recover the lua function parameter
	if(lua_isfunction(L, -1)) {
		lua_rawgeti(L, -2, 2); //recover the lua user_data parameter
		lua_call(L, 1, 0);
	}
  }
  lua_settop(L, savedTop);
}

int set_fltk_fl_add_idle(lua_State* L, lua_Function luaFunc, lua_Object obj)
{
	if(luaFunc){
		lua_createtable(L, 2, 0); //new table to store function to call and user_data
		lua_pushvalue(L, luaFunc);
		lua_rawseti(L, -2, 1);
		if(obj) lua_pushvalue(L, obj);
		else lua_pushnil(L);
		lua_rawseti(L, -2, 2);
		int ref = luaL_ref(L, LUA_REGISTRYINDEX);
		//printf("set_fltk_fl_add_idle %d, %d, %d\n", luaFunc, obj, ref);
		Fl::add_idle(&lua_fltk_fl_idle, (void *) ref);
		return ref;
	}
	return 0;
}

void fltk_fl_remove_idle(lua_State* L, int ref)
{
	//printf("remove_idle %d\n", ref);
	Fl::remove_idle(&lua_fltk_fl_idle, (void *) ref);
	luaL_unref(L, LUA_REGISTRYINDEX, ref);
}

static void lua_fltk_fl_timeout(void * udata)
{
  lua_State* L = (lua_State*)Fl::user_data;
  int savedTop = lua_gettop(L);
  lua_checkstack(L, 20);
  lua_rawgeti(L, LUA_REGISTRYINDEX, (int)udata);
  if(lua_istable(L, -1)) {
    int refTbl = lua_gettop(L);
	lua_rawgeti(L, refTbl, 1); //recover the lua function parameter
	if(lua_isfunction(L, -1)) {
		lua_rawgeti(L, refTbl, 2); //recover the lua user_data parameter
		lua_call(L, 1, 0);
	}
	lua_pushliteral(L, "repeat");
	lua_rawget(L, refTbl);
	if(!lua_isboolean(L, -1) && !lua_toboolean(L, -1))
		luaL_unref(L, LUA_REGISTRYINDEX, (int)udata);
  }
  lua_settop(L, savedTop);
}

int set_fltk_fl_add_timeout(lua_State* L, double t, lua_Function luaFunc, lua_Object obj)
{
	if(luaFunc){
		lua_createtable(L, 2, 1); //new table to store function to call and user_data
		lua_pushvalue(L, luaFunc);
		lua_rawseti(L, -2, 1);
		if(obj) lua_pushvalue(L, obj);
		else lua_pushnil(L);
		lua_rawseti(L, -2, 2);
	    lua_pushliteral(L, "repeat");
	    lua_pushboolean(L, 0);
		lua_rawset(L, -3);
		int ref = luaL_ref(L, LUA_REGISTRYINDEX);
		Fl::add_timeout(t, &lua_fltk_fl_timeout, (void *) ref);
		return ref;
	}
	return 0;
}

void set_fltk_fl_repeat_timeout(lua_State* L, double t, int ref)
{
  int savedTop = lua_gettop(L);
  lua_rawgeti(L, LUA_REGISTRYINDEX, ref);
  if(lua_istable(L, -1)) {
    lua_pushliteral(L, "repeat");
    lua_pushboolean(L, 1);
	lua_rawset(L, -3);
	//printf("repeat_timeout %d\n", ref);
	Fl::repeat_timeout(t, &lua_fltk_fl_timeout, (void *) ref);
  }
  lua_settop(L, savedTop);
}

void fltk_fl_remove_timeout(lua_State* L, int ref)
{
	Fl::remove_timeout(&lua_fltk_fl_timeout, (void *) ref);
	luaL_unref(L, LUA_REGISTRYINDEX, ref);
}

#if 0

#define LUA_REGISTRYWEAKVALUES LUA_REGISTRYUSER1

  //make the LUA_REGISTRYUSER1 a weak value registry
  //for use to connect c++ objects with their lua proxies
  //and facilitate virtual functions calls
  lua_pushvalue(__S__, LUA_REGISTRYWEAKVALUES);
  lua_newtable(__S__);
  lua_pushliteral(__S__, "v");
  lua_setfield(__S__, -2, "__mode");
  lua_setmetatable (__S__, -2);

  lua_settop(__S__, 0);


static int lua_refObjectsToThenselves(lua_State * __S__) {
	//userdata should be on top of the stack
	//push the object key
	lua_pushlightuserdata(__S__, *(void * *)lua_touserdata(__S__, -1));
	lua_pushvalue(__S__, -2); //push a copy of userdata becuase it will be poped next
	//create a ref for the userdata on top of the stack
	lua_settable(__S__, LUA_REGISTRYWEAKVALUES);
	return 0;
}

#define lua_unrefObjectsToThenselves(L, ref) luaL_unref(L, LUA_REGISTRYWEAKVALUES, ref)
#define lua_pushRefObjectsToThenselves0(L, ref) lua_rawgeti(L, LUA_REGISTRYWEAKVALUES, ref)
#define lua_pushRefObjectsToThenselves(L, ptr) \
	lua_pushlightuserdata(L, ptr);\
	lua_gettable(L, LUA_REGISTRYWEAKVALUES)

int lua_set_function_reference(lua_State *L, int &ref){
		if(lua_isfunction(L, -1)){ //create a ref for the userdata on top of the stack
			if(ref){
				luaL_unref(L, LUA_REGISTRYINDEX, ref);
				ref = 0;
			}
			ref = luaL_ref(L, LUA_REGISTRYINDEX);
			return ref;
		}
		return 0;
	};

static int lua_fltk_gc(lua_State *L) {
	lua_pushliteral(L, "on_destroy");
	lua_gettable(L, 1);
	if(lua_isfunction(L, -1)){
		lua_pushvalue(L, 1); //pass the self paramter
		lua_call(L, 1, 0);
	}
    return 0;
}

#endif

class Lua_Fl_Pixmap: public Fl_Pixmap {
	public:
	char **imageData;
	Lua_Fl_Pixmap(lua_State* __S__, lua_Object tbl);
	~Lua_Fl_Pixmap() {delete imageData;};
	void myset_data(const char * const * p);
};


Lua_Fl_Pixmap::Lua_Fl_Pixmap(lua_State* __S__, lua_Object tbl) : Fl_Pixmap((const char * const *)NULL) {
  if (lua_istable(__S__, tbl))
  {
    int counter = lua_objlen(__S__, tbl);
	imageData = new char *[counter];

	for(int i=0; i < counter; i++){
		// stack issues ... See : http://lua-users.org/lists/lua-l/2007-09/msg00435.html
		// This code is only good for string data
		// printf("Data : \"%s\"\n", lua_tostring(__S__, -1));
		lua_rawgeti(__S__, tbl, i+1);
		imageData[i] = (char *) lua_tostring(__S__, -1);
    }
	myset_data(imageData);
	measure();
  }
};

void Lua_Fl_Pixmap::myset_data(const char * const * p) {
  int	height,		// Number of lines in image
	ncolors;	// Number of colors in image

  if (p) {
    sscanf(p[0],"%*d%d%d", &height, &ncolors);
    if (ncolors < 0) data(p, height + 2);
    else data(p, height + ncolors + 1);
  }
}

Fl_Pixmap* new_fltk_Fl_Pixmap(lua_State* L, lua_Object tbl){
	return (Fl_Pixmap*)new Lua_Fl_Pixmap(L, tbl);
}

extern struct Smain {
  int argc;
  char **argv;
  int status;
} gAppArgs;

void fltk_Fl_Window_show(Fl_Window *win, lua_State* L){
	int i;
	Fl::args(gAppArgs.argc, gAppArgs.argv, i);
	win->show(gAppArgs.argc, gAppArgs.argv);
}

static int fltk_global_focus_changing_handler_ref = 0;

static int fltk_global_focus_changing_handler(Fl_Widget *from, Fl_Widget *to)
{
  lua_State* L = (lua_State*)Fl::user_data;
  int oldtop = lua_gettop(L);

  lua_rawgeti(L, LUA_REGISTRYINDEX, fltk_global_focus_changing_handler_ref);
  if (lua_isfunction(L, -1)){
  	tolua_pushusertype(L,(void*)from,"Fl_Widget");
  	tolua_pushusertype(L,(void*)to,"Fl_Widget");
  	lua_call(L, 2, 1);
  	return (int)lua_tonumber(L, -1);
  }
  lua_settop(L, oldtop);
  return 0;
}

int fltk_fl_add_focus_changing_handler(lua_State* L, lua_Function luaFunc)
{
  if (!fltk_global_focus_changing_handler_ref)
  {
	lua_pushvalue(L, luaFunc);
	fltk_global_focus_changing_handler_ref = luaL_ref(L, LUA_REGISTRYINDEX);
	Fl::add_focus_changing_handler(&fltk_global_focus_changing_handler);
	return 1;
  }
  return 0;
}

void fltk_fl_remove_focus_changing_handler(lua_State* L)
{

	if (fltk_global_focus_changing_handler_ref){
		luaL_unref(L, LUA_REGISTRYINDEX, fltk_global_focus_changing_handler_ref);
		fltk_global_focus_changing_handler_ref = 0;
  		Fl::remove_focus_changing_handler();
	}
}

void fltk_Fl_Browser_set_column_widths(Fl_Browser* brw, lua_State* L, lua_Object tbl)
{
  if(lua_istable(L, tbl)) {
	int arr_size = lua_objlen(L, tbl);
	int* arr_old = brw->column_widths_owned();
  	int *arr = (int*) malloc((arr_size+1)*sizeof(int));
	int i;
	for(i=0; i<arr_size;i++){
	  lua_pushnumber(L, i+1);
	  lua_gettable(L, tbl);
	  arr[i] = lua_tointeger(L,-1);
	}
	arr[i] = 0;
  	brw->column_widths_owned(arr);
  	if(arr_old) free(arr_old);
 }
}

lua_Object fltk_Fl_Browser_get_column_widths(Fl_Browser* brw, lua_State* L)
{
  	const int* arr = brw->column_widths();
	int i;
	lua_newtable(L);
	for(i=1; *arr; i++, arr++){
	  lua_pushnumber(L, i);
	  lua_pushnumber(L, *arr);
	  lua_settable(L, -3);
	}
 	return -1;
}

void fltk_Fl_Window_load_icon(Fl_Window* win, char *id){
#ifdef WIN32
  void *icon = (void *)LoadIcon(fl_display, id);
  if(icon) win->icon(icon);
#endif
}

static void lua_fltk_menu_item_callback(Fl_Widget * w, void *data)
{
  lua_State* L = (lua_State*)Fl::user_data;
  int savedTop = lua_gettop(L);
  lua_checkstack(L, 20);
  lua_rawgeti(L, LUA_REGISTRYINDEX, (int)data);
  if (lua_istable(L, -1)){
  	lua_rawgeti(L, -1, 1);
  	if (lua_isfunction(L, -1)){
  		tolua_pushusertype(L,(void*)w,w->classId());
  		lua_rawgeti(L, -2, 2); //userdata
  		lua_call(L, 2, 0);
  	}
  }
  lua_settop(L, savedTop);
}

#define MK_REF_FUNC_DATA()\
	int ref_data;\
	lua_newtable(L);\
	lua_pushnumber(L, 1);\
	lua_pushvalue(L, luaFunc);\
	lua_settable(L, -3);\
	lua_pushnumber(L, 2);\
	lua_pushvalue(L, data);\
	lua_settable(L, -3);\
	ref_data = luaL_ref(L, LUA_REGISTRYINDEX);


void set_fltk_menu_item_callback(Fl_Menu_Item *w, lua_State* L, lua_Function luaFunc,
	lua_Object data)
{
	MK_REF_FUNC_DATA();
	int old_data = (int)w->user_data();
	if(old_data) luaL_unref(L, LUA_REGISTRYINDEX, old_data);
	w->callback(&lua_fltk_menu_item_callback, (void*)ref_data);
}

#define SET_MENU_ITEM_PARAMS()\
	Fl_Menu_Item *mi = self->menu_at(index);\
	switch(lua_type(L, shortcut)){\
		case LUA_TSTRING: mi->shortcut(fl_old_shortcut(lua_tostring(L, shortcut)));\
			break;\
		case LUA_TNUMBER: mi->shortcut(lua_tointeger(L, shortcut));\
			break;\
	}\
	if(!lua_isnil(L, luaFunc))\
		set_fltk_menu_item_callback(mi, L, luaFunc, data);\
	return index;

int fltk_fl_menu_item_add(Fl_Menu_Item* self, lua_State* L, const char *label,
		lua_Object shortcut, lua_Function luaFunc, lua_Object data, int flags){
	int index = self->add(label, 0, NULL, NULL, flags);
	SET_MENU_ITEM_PARAMS();
}

int fltk_fl_menu_item_insert(Fl_Menu_Item* self, lua_State* L, int at_index, const char *label,
		lua_Object shortcut, lua_Function luaFunc, lua_Object data, int flags){

	int index = self->insert(at_index, label, 0, NULL, NULL, flags);
	SET_MENU_ITEM_PARAMS();
}

int fltk_fl_menu_add(Fl_Menu_* self, lua_State* L, const char *label,
		lua_Object shortcut, lua_Function luaFunc, lua_Object data, int flags){

	int index = self->add(label, 0, NULL, NULL, flags);
	SET_MENU_ITEM_PARAMS();
}

int fltk_fl_menu_insert(Fl_Menu_* self, lua_State* L, int at_index, const char *label,
		lua_Object shortcut, lua_Function luaFunc, lua_Object data, int flags){

	int index = self->insert(at_index, label, 0, NULL, NULL, flags);
	SET_MENU_ITEM_PARAMS();
}
