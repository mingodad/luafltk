This is another effort to have a FLTK binding to the LUA language, it uses a modified tolua++ to generate the bindings and some hand code for special cases.

The lua language is based on 5.1.4 plus some patches, some of the from the AGENA language (another LUA variant).

The FLTK also is a slight modified 1.3 with printing support.

It also comes with sqlite3 included.

Also some code and ideas from murgaLua project, wxlua project.

A more complete list of software and contributors will follow.

Main differences from the plain Lua 5.1.4:
  * Added a "continue" keyword for loops
  * Add "break N" to break N nested loops
  * Added the "inc" and "dec" keywords to increment and decrement numbers (from agena)
  * Added "case of esac" from agena
  * Added "!=" as not equal operator
  * Added "->" syntatic sugar for class like tables
