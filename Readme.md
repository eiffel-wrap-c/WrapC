# WrapC

`WrapC` is an Eiffel wrapper generator for C libraries, originally known as EWG (http://www.sourceforge.net/projects/ewg)
It can be used to create libraries that bridge the gap between Eiffel and C. It aims to work for arbitrary ANSI C and with EiffelSoftware compiler.


## WrapC Status
Wrap C is a new version of an old project named [EWG](http://www.sourceforge.net/projects/ewg).
It was updated to use the latest Eiffel version. `WrapC` generates Eiffel wrappers using inline externals whenever is possible.  Updated callback code generation to usign agent to register Eiffel feature to be called after a callback. Updated framework to automate building libraries and applications that use Wrap_c.

### Current Features

	 Parses pretty much all ANSI C, but also understands gcc and Visual C extensions
	 Generates wrappers for: 	

*   _Structs_
*   _Unions_
*   _Enums_
*   _Functions_
*   _Callbacks_

#### Note 

	*   Macros are not supported for now.

*	Works with ISE Eiffel.
*	Includes a framework to automate building libraries and applications that use `WrapC`. 


The [Getting started](./doc/Readme.md) lets you discover the `WrapC` tool.
The [Developer guide](./doc/developer/Readme.md) lets you know how to build `WrapC` tool.
