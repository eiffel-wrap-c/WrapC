#!/bin/sh
# Post processing script

# copy c file is there any
cp ./manual_wrapper/c/src/*.c  ./generated_wrapper/c/src	

#copy geant script
cp finish_freezing.eant  ./generated_wrapper/c/src/geant.eant	

#copy Makefile
cp Makefile.SH  ./generated_wrapper/c/src
