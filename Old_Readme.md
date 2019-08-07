About:
------

Ewg is a eiffel wrapper generator for C based


New EWG Version
--------
Updated code to use the latest Eiffel version.
Generates Eiffel wrappers using inline externals whenever is possible.
Updated geant scripts to use the latest Gobo version.

TODO
-------
Update test case generation
Update geant script for examples 


Documentation:
---------

You can find documentation for ewg in the subdirectory "doc/html".

If you have further questions please ask them on the
ewg-devel mailing list at http://www.sourceforge.net/projects/ewg

Preprocessing:
--------------

EWG expects it's header file to be preprocessed.
There is a special geant file (${EWG}/misc/ewg_common.eant)
which can be inherited by libraries that wrap C libraries,
which takes care about preprocessing and other things.
Have a look at the examples to find out how to use it.

Note on Licensing:
------------------

(I am no lawyer, so what I write here might be completly wrong.)
Since the task of creating a wrapper from a C library can be automated 
(as this tool proves) it is very likely that the output (the generated wrapper)
can be classified as a derived work from the original C library. There are licences 
require you to put the derived work (e.g. the generated wrapper) 
under the same licences as the original work (e.g. the C library).
Some licences might be weaker on this issue, some might be stronger
(e.g. prohibit derived work at all).

On a similar not I should mention that the ANSI C gramars 
have been taken from http://www.lysator.liu.se/c . The license
seems to be unclear, but the maintainer of the site told me
it was ok to use it.

Also parts of the source where taken from GOTE (notably the now rewritten CONSOLE_TICKER).

Swig:
-----

I do know there is swig-eiffel, which has a similar goal as ewg.
The reason for not starting from swig-eiffel but rather starting
from scratch with a pure Eiffel application is simple: I don't like
programing in C. I do ewg in my spare time, and I don't like to do
things in my spare time, which I don't enjoy (;

Contact:
-------

www: http://ewg.sourceforge.net
email: Andreas Leitner (aleitner@raboof.at)