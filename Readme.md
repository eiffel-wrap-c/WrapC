<h1>Wrap_C</h1>

Wrap_C is an Eiffel wrapper generator for C libraries, originally known as EWG (http://www.sourceforge.net/projects/ewg)
It can be used to create libraries that bridge the gap between Eiffel and C. It aims to work for arbitrary ANSI C and with EiffelSoftware compiler.


<h2>Wrap_C Status</h2>
Wrap C is a new version of an old project named [EWG](http://www.sourceforge.net/projects/ewg).
It was updated to use the latest Eiffel version. `Wrap_C` generates Eiffel wrappers using inline externals whenever is possible.  Updated callback code generation to usign agent to register Eiffel feature to be called after a callback. Updated framework to automate building libraries and applications that use Wrap_c.

<h3>Current Features</h3>

	 Parses pretty much all _ANSI C_, but also understands _gcc_ and _Visual C _extensions
	 Generates wrappers for: 	

*   _Structs_
*   _Unions_
*   _Enums_
*   _Functions_
*   _Callbacks_

<h4>Note</h4>

*   **Macros are not supported for now.**

*	Works with ISE Eiffel.
*	Includes framework to automate building libraries and applications that use Wrap_C 


The [Getting started](./doc/Readme.md) lets you discover the WrapC tool.