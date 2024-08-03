#!/bin/bash

# Runs in container after startup for initial installation

# Install VCRedist for CWSL
/usr/local/bin/winetricks -q vcrun2010 

# Install VCRedist for CWSL_DIGI
/usr/local/bin/winetricks -q vcrun2022

cd /install/SkimmerSrv_1.6
wine Setup.exe /SILENT
