#!/bin/bash
# Install CWSL

cd prefix32/drive_c/windows/system32
unzip -n ~/IPP70.zip 

wine vcredist_x86.exe 

cd /install/SkimmerSrv_1.6
wine Setup.exe /SILENT

unzip CWSL.zip

cd "/root/prefix32/drive_c/Program Files/Afreet/SkimSrv"
cp ~/CWSL_Tee.dll .
cp ~/CWSL_Tee.cfg  .


cp ~/