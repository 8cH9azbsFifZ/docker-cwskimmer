                              Skimmer Server 1.6
                              ------------------
                          
                          
Skimmer Server

Skimmer Server is a multi-band, multi-channel CW decoder that sits in the 
System Tray and posts the decoded callsigns via Telnet in the standard
DX Cluster format. It uses a single SDR receiver to decode CW on up to 7
different bands simultaneously.

This program works only with the QS1R receiver (http://www.srl-llc.com/) and
requires a USB driver for that radio. The easiest way to ensure that the driver
is available is to install the SDRMAXII software that comes with the radio.
Both WinUSB and libusb0 drivers are supported, Skimmer Server will use 
the one that is currently installed. 

Skimmer Server is a SysTray application. It does not have a GUI window to show
on startup, the only indicator of its presence is the icon in the System Tray.
Click on that icon to open the combined Status / Settings dialog. Note that
closing the dialog does not stop the server, use the Exit command in the 
right-click menu of the icon to stop it.
     

     
Quick Start

Make sure that no other programs on your computer are listening on Port 7300.

Make sure that no other programs are using the QS1R receiver. In particular, the
software that comes with QS1R, namely QS1RServer and SDRMAX, should not be
running.

Start the server.

Open the Settings dialog and enter your callsign and other data on the Operator
tab. Click on Apply.

You can use the Telnet client that comes with Windows to view the spots. to do
so, open the DOS box and type:

telnet localhost 7300

Enter your callsign when prompted, and the spots will start coming. Type SH/DX
to see the old spots.



Configuration

The program is pre-configured to decode on 3 bands with a bandwidth of 48 kHz.
On most computers you can change this to 96 kHz or 192 kHz on 7 bands and
still have a pretty low CPU load.

Note that QS1R, when used in the 7-band 192-kHz mode, requires a 2-Amp power
supply. The PS that comes with QS1R (5V, 1A) cannot be used in this mode.

The Number of Threads should be set to 1 unless you have a multi-CPU system.
 
Frequency calibration may be required if the clock frequency of the radio differs
from its nominal value. The calibration factor is stored in the SkimSrv.ini file,
e.g.:

FreqCalibration=1.0000082

If you have CW Skimmer installed and calibrated, you can copy the calibration
factor from CwSkimmer.ini, otherwise compute the factor as
DisplayedFrequency / TrueFrequency.




Version History

V.1.6
 - improved prefix validation;
 - spots with SNR >= 70 dB are blocked.
 
 
V.1.5
 - improved decoding accuracy;
 - bugs fixed.
 
 
V.1.4
 - support of Watch List added.
 

V.1.3
  - improved message analysis;
  - SKIMMER/SETT command added;
  - black list added;


V.1.2
  - improved detection of invalid calls and CQ/DE status;
  - improved speed.


V.1.1
  - improved CQ/DE detection;
  - improved dupe rejection;
  - frequency calibration;
  - improved spot archive format.
   
   
 V.1.0
   first release.
   




Please send your feedback to alshovk@dxatlas.com.




73 Alex VE3NEA

