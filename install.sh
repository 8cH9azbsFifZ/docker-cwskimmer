#!/bin/bash
echo "Running Installer"

# Runs in container after startup for initial installation
test -e /install/done && exit 0

echo "Starting installer for the 1st time"

sleep 15

WINEARCH=win32 WINEPREFIX=/root/.wine32 winecfg 
/usr/local/bin/winetricks -q dotnet46


# Install VCRedist for CWSL
/usr/local/bin/winetricks -q vcrun2010 

# Install VCRedist for CWSL_DIGI
/usr/local/bin/winetricks -q vcrun2022

msiexec /q /i /install/Intel_Fortran/ww_ifort_redist_intel64_2020.4.311.msi

msiexec /q /i /install/pskreporter/CWReporter.msi

wine /install/WSJTX/wsjtx-2.6.1-win32.exe /S

echo "Installer done for the 1st time"
touch /install/done 