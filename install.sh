#!/bin/bash

# Runs in container after startup for initial installation

# Install VCRedist for CWSL
/usr/local/bin/winetricks -q vcrun2010 

# Install VCRedist for CWSL_DIGI
/usr/local/bin/winetricks -q vcrun2022

msiexec /q /i /install/Intel_Fortran/ww_ifort_redist_intel64_2020.4.311.msi

wine /install/WSJTX/wsjtx-2.6.1-win32.exe /S