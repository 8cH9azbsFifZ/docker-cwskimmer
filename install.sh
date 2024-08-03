#!/bin/bash

# Runs in container after startup for initial installation

# Install VCRedist for CWSL
/usr/local/bin/winetricks -q vcrun2010 

cd /install/SkimmerSrv_1.6
wine Setup.exe /SILENT
