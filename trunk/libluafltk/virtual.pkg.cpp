/*
** Lua binding: virtual
** Generated automatically by tolua++-1.0.92 on 05/31/10 17:23:04.
*/

#ifndef __cplusplus
#include "stdlib.h"
#endif
#include "string.h"

#include "tolua++.h"

#ifdef __cplusplus
 extern "C" {
#endif
/* Exported function */
TOLUA_API int tolua_virtual_open (lua_State* tolua_S);
#ifdef __cplusplus
}
#endif

#include "tolua_base.h"

/* function to release collected object via destructor */
#ifdef __cplusplus

static int tolua_collect_Widget (lua_State* tolua_S)
{
 Widget* self = (Widget*) tolua_tousertype(tolua_S,1,0);
 Mtolua_delete(self);
 return 0;
}
#endif


/* function to register type */
static void tolua_reg_types (lua_State* tolua_S)
{
 tolua_usertype(tolua_S,"Lua__Widget");
 tolua_usertype(tolua_S,"Event");
 tolua_usertype(tolua_S,"Widget");
}

/* method: add_child of class  Widget */
#ifndef TOLUA_DISABLE_tolua_virtual_Widget_add_child00
static int tolua_virtual_Widget_add_child00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
 !tolua_isusertype(tolua_S,1,"Widget",0,&tolua_err) ||
 !tolua_isusertype(tolua_S,2,"Widget",0,&tolua_err) ||
 !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
 goto tolua_lerror;
 else
#endif
 {
  Widget* self = (Widget*)  tolua_tousertype(tolua_S,1,0);
  Widget* child = ((Widget*)  tolua_tousertype(tolua_S,2,0));
#ifndef TOLUA_RELEASE
 if (!self) tolua_error(tolua_S,"invalid 'self' in function 'add_child'", NULL);
#endif
 {
  self->add_child(child);
 }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'add_child'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: close of class  Widget */
#ifndef TOLUA_DISABLE_tolua_virtual_Widget_close00
static int tolua_virtual_Widget_close00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
 !tolua_isusertype(tolua_S,1,"Widget",0,&tolua_err) ||
 !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
 goto tolua_lerror;
 else
#endif
 {
  Widget* self = (Widget*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
 if (!self) tolua_error(tolua_S,"invalid 'self' in function 'close'", NULL);
#endif
 {
  self->close();
 }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'close'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: new of class  Widget */
#ifndef TOLUA_DISABLE_tolua_virtual_Widget_new00
static int tolua_virtual_Widget_new00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
 !tolua_isusertable(tolua_S,1,"Widget",0,&tolua_err) ||
 !tolua_iscppstring(tolua_S,2,0,&tolua_err) ||
 !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
 goto tolua_lerror;
 else
#endif
 {
  string p_name = ((string)  tolua_tocppstring(tolua_S,2,0));
 {
  Widget* tolua_ret = (Widget*)  Mtolua_new((Widget)(p_name));
  tolua_pushusertype(tolua_S,(void*)tolua_ret,"Widget");
 }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'new'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: new_local of class  Widget */
#ifndef TOLUA_DISABLE_tolua_virtual_Widget_new00_local
static int tolua_virtual_Widget_new00_local(lua_State* tolua_S)
{
 int result = tolua_virtual_Widget_new00(tolua_S);
 if(result) tolua_register_gc(tolua_S,lua_gettop(tolua_S));
 return result;
}
#endif //#ifndef TOLUA_DISABLE

 class Lua__Widget : public Widget, public ToluaBase {
public:
	 bool  input_event( Event* e) {
		if (push_method("input_event",  NULL)) {
			tolua_pushusertype(lua_state, (void*)e, "Event");
			ToluaBase::dbcall(lua_state, 2, 1);
			 bool  tolua_ret = ( bool )tolua_toboolean(lua_state, -1, 0);
			lua_pop(lua_state, 1);
			return tolua_ret;
		} else {
			return ( bool ) Widget:: input_event(e);
		};
	};
	 void  add_child( Widget* child) {
		if (push_method("add_child",  tolua_virtual_Widget_add_child00)) {
			tolua_pushusertype(lua_state, (void*)child, "Widget");
			ToluaBase::dbcall(lua_state, 2, 0);
		} else {
			return ( void ) Widget:: add_child(child);
		};
	};

	 bool Widget__input_event( Event* e) {
		return ( bool )Widget::input_event(e);
	};
	 void Widget__add_child( Widget* child) {
		return ( void )Widget::add_child(child);
	};
	 Lua__Widget( string p_name): Widget(p_name){};
};

/* method: tolua__set_instance of class  Lua__Widget */
#ifndef TOLUA_DISABLE_tolua_virtual_Lua__Widget_tolua__set_instance00
static int tolua_virtual_Lua__Widget_tolua__set_instance00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
 !tolua_isusertype(tolua_S,1,"Lua__Widget",0,&tolua_err) ||
 !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
 goto tolua_lerror;
 else
#endif
 {
  Lua__Widget* self = (Lua__Widget*)  tolua_tousertype(tolua_S,1,0);
  lua_State* L =  tolua_S;
  lua_Object lo = ((lua_Object)  tolua_tovalue(tolua_S,2,0));
#ifndef TOLUA_RELEASE
 if (!self) tolua_error(tolua_S,"invalid 'self' in function 'tolua__set_instance'", NULL);
#endif
 {
  self->tolua__set_instance(L,lo);
 }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'tolua__set_instance'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: Widget__input_event of class  Lua__Widget */
#ifndef TOLUA_DISABLE_tolua_virtual_Lua__Widget_Widget__input_event00
static int tolua_virtual_Lua__Widget_Widget__input_event00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
 !tolua_isusertype(tolua_S,1,"Lua__Widget",0,&tolua_err) ||
 !tolua_isusertype(tolua_S,2,"Event",0,&tolua_err) ||
 !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
 goto tolua_lerror;
 else
#endif
 {
  Lua__Widget* self = (Lua__Widget*)  tolua_tousertype(tolua_S,1,0);
  Event* e = ((Event*)  tolua_tousertype(tolua_S,2,0));
#ifndef TOLUA_RELEASE
 if (!self) tolua_error(tolua_S,"invalid 'self' in function 'Widget__input_event'", NULL);
#endif
 {
  bool tolua_ret = (bool)  self->Widget__input_event(e);
 tolua_pushboolean(tolua_S,(bool)tolua_ret);
 }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'Widget__input_event'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: Widget__add_child of class  Lua__Widget */
#ifndef TOLUA_DISABLE_tolua_virtual_Lua__Widget_Widget__add_child00
static int tolua_virtual_Lua__Widget_Widget__add_child00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
 !tolua_isusertype(tolua_S,1,"Lua__Widget",0,&tolua_err) ||
 !tolua_isusertype(tolua_S,2,"Widget",0,&tolua_err) ||
 !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
 goto tolua_lerror;
 else
#endif
 {
  Lua__Widget* self = (Lua__Widget*)  tolua_tousertype(tolua_S,1,0);
  Widget* child = ((Widget*)  tolua_tousertype(tolua_S,2,0));
#ifndef TOLUA_RELEASE
 if (!self) tolua_error(tolua_S,"invalid 'self' in function 'Widget__add_child'", NULL);
#endif
 {
  self->Widget__add_child(child);
 }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'Widget__add_child'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: new of class  Lua__Widget */
#ifndef TOLUA_DISABLE_tolua_virtual_Lua__Widget_new00
static int tolua_virtual_Lua__Widget_new00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
 !tolua_isusertable(tolua_S,1,"Lua__Widget",0,&tolua_err) ||
 !tolua_iscppstring(tolua_S,2,0,&tolua_err) ||
 !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
 goto tolua_lerror;
 else
#endif
 {
  string p_name = ((string)  tolua_tocppstring(tolua_S,2,0));
 {
  Lua__Widget* tolua_ret = (Lua__Widget*)  Mtolua_new((Lua__Widget)(p_name));
  tolua_pushusertype(tolua_S,(void*)tolua_ret,"Lua__Widget");
 }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'new'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: new_local of class  Lua__Widget */
#ifndef TOLUA_DISABLE_tolua_virtual_Lua__Widget_new00_local
static int tolua_virtual_Lua__Widget_new00_local(lua_State* tolua_S)
{
 int result = tolua_virtual_Lua__Widget_new00(tolua_S);
 if(result) tolua_register_gc(tolua_S,lua_gettop(tolua_S));
 return result;
}
#endif //#ifndef TOLUA_DISABLE


/* function to release collected object via destructor */
#ifdef __cplusplus

static int tolua_collect_Lua__Widget (lua_State* tolua_S)
{
 Lua__Widget* self = (Lua__Widget*) tolua_tousertype(tolua_S,1,0);
	delete self;
	return 0;
}
#endif

/* Open function */
TOLUA_API int tolua_virtual_open (lua_State* tolua_S)
{
 tolua_open(tolua_S);
 tolua_reg_types(tolua_S);
 tolua_module(tolua_S,NULL,0);
 tolua_beginmodule(tolua_S,NULL);
 #ifdef __cplusplus
 tolua_cclass(tolua_S,"Widget","Widget","",tolua_collect_Widget);
 #else
 tolua_cclass(tolua_S,"Widget","Widget","",NULL);
 #endif
 tolua_beginmodule(tolua_S,"Widget");
  tolua_function(tolua_S,"add_child",tolua_virtual_Widget_add_child00);
  tolua_function(tolua_S,"close",tolua_virtual_Widget_close00);
  tolua_function(tolua_S,"new",tolua_virtual_Widget_new00);
  tolua_function(tolua_S,"new_local",tolua_virtual_Widget_new00_local);
  tolua_function(tolua_S,".call",tolua_virtual_Widget_new00_local);
 tolua_endmodule(tolua_S);
 #ifdef __cplusplus
 tolua_cclass(tolua_S,"Lua__Widget","Lua__Widget","Widget",tolua_collect_Lua__Widget);
 #else
 tolua_cclass(tolua_S,"Lua__Widget","Lua__Widget","Widget",NULL);
 #endif
 tolua_beginmodule(tolua_S,"Lua__Widget");
  tolua_function(tolua_S,"tolua__set_instance",tolua_virtual_Lua__Widget_tolua__set_instance00);
  tolua_function(tolua_S,"Widget__input_event",tolua_virtual_Lua__Widget_Widget__input_event00);
  tolua_function(tolua_S,"Widget__add_child",tolua_virtual_Lua__Widget_Widget__add_child00);
  tolua_function(tolua_S,"new",tolua_virtual_Lua__Widget_new00);
  tolua_function(tolua_S,"new_local",tolua_virtual_Lua__Widget_new00_local);
  tolua_function(tolua_S,".call",tolua_virtual_Lua__Widget_new00_local);
 tolua_endmodule(tolua_S);
 tolua_endmodule(tolua_S);
 return 1;
}


#ifdef __cplusplus
 extern "C" {
#endif

#if defined(LUA_VERSION_NUM) && LUA_VERSION_NUM >= 501
 TOLUA_API int luaopen_virtual (lua_State* tolua_S) {
 return tolua_virtual_open(tolua_S);
};
#endif

#ifdef __cplusplus
}
#endif

