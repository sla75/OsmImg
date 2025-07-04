echo off
echo -
echo -
echo -  This batch will uninstall map from Mapsource.
echo -
echo -  Map:  "MTB"
echo -  FID:  9999
echo -  PID:  2
echo -
echo -  Press Enter to continue or Ctrl-C to abort.
echo -
pause

set KEY=HKLM\SOFTWARE\Wow6432Node\Garmin\MapSource
if %PROCESSOR_ARCHITECTURE% == AMD64 goto key_ok
set KEY=HKLM\SOFTWARE\Garmin\MapSource
:key_ok

reg DELETE %KEY%\Families\FAMILY_9999 /f
pause
exit 0
