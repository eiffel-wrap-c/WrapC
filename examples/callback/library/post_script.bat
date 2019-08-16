@echo off
title post_process script

rem copy c file is there any
copy .\manual_wrapper\c\src\*.c  .\generated_wrapper\c\src	

rem copy geant script
copy finish_freezing.eant  .\generated_wrapper\c\src\geant.eant	

rem copy Makefile script
copy Makefile-win.SH  .\generated_wrapper\c\src