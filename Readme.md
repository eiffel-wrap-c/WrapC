<h1>Wrap_C</h1>

Wrap_C is an Eiffel wrapper generator for C libraries, originally known as EWG (http://www.sourceforge.net/projects/ewg)
It can be used to create libraries that bridge the gap between Eiffel and C. It aims to work for arbitrary ANSI C and with EiffelSoftware compiler.

[TOC]
										
							Work in progress

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

<h2>Installation</h2>


<h3>**Getting Wrap C**</h3>
https://github.com/eiffel-wrap-c/wrap_c

<h3>**Requirements**</h3>

Library

*   Gobo 19.03 or newer.

Compiler

*   EiffelStudio 19.05 or newer

Platform

*   Everything supported by above requirements (At the moment only tested on Windows)

<h3>**Setting Wrap_c**</h3>

The following describes actions that should be taken to properly setup `Wrap_c`.

Once you have `Wrap_c`tool installed , you should define the following environment variables in order to run Wrap_c wrapper generator



*   Set WRAP_C to the directory where you unpacked Wrap_c code.
*   Set GOBO_EIFFEL to ISE Eiffel compiler (ise).
*   Put ${WRAP_C}/bin into your ${PATH} environment variable

The following example shows a possible setup for windows:

	 set WRAP_C=C:\ewg
	 set PATH=%PATH%;%WRAP_C%\bin
	 set GOBO_EIFFEL=ise
	 set GOBO_CC=msc     


<h3>**Compiling the Tools**</h3>
The following will use the Gobo geant tool to setup and install the source code.

	 cd ${WRAP_C}
	 geant install
	 geant compile

Another approach is to use the corresponding ecf’s and open them with EiffelStudio, (To be completed)
<h2>**How to create your own Wrapper**</h2>

To generate a new Eiffel wrapper, the simplest way is to start from the template wrapping example located at {WRAP_C}/example/template

<h3>**Directory Structure**</h3>


	template	
		example        -- examples using the library 
		library        -- generated wrapper and the manual wrapping.
		test	       -- code to test the library
	        config.xml     -- configuration file to customize the way EWG generates the wrapper.
	        build.eant     -- build script
	        library.ecf    -- library configuration file.

<h3>**Updating the configuration file**</h3>

```
<?xml version="1.0"?>
<ewg_config name="my_example">

<rule_list>
   <!-- This rule matches all C constructs who are named "foo". -->
   <!-- Matching constructs will be wrapped using Wrap_c s defaults -->

<rule>
  <match>
	 <identifier name="foo"/>
  </match>
  <wrapper type="default">
  </wrapper>
</rule>

  <!-- This rule matches all C constructs.         -->
  <!-- Matching constructs will be ignored.        -->
  <!-- Thus no wrapper will be generated for them  -->

<rule>
  <match>
  </match>
  <wrapper type="none">
  </wrapper>
</rule>

</rule_list>

</ewg_config>
```

