#!/bin/bash


cd /install/SkimmerSrv_1.6
wine Setup.exe /SILENT

unzip CWSL.zip

cd "/root/prefix32/drive_c/Program Files/Afreet/SkimSrv"
cp ~/CWSL_Tee.dll .
cp ~/CWSL_Tee.cfg  .


cp ~/