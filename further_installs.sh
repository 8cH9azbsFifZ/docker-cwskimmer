#!/bin/bash
# Install CWSL

cd prefix32/drive_c/windows/system32
unzip -u ~/IPP70.zip 

wine vcredist_x86.exe 


unzip CWSL.zip


cd "prefix32/drive_c/Program Files/Afreet/SkimSrv"
cp ~/CWSL_Tee.dll .
cp ~/CWSL_Tee.cfg  .