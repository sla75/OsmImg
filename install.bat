echo off
echo -
echo -
echo -  This batch will install map for Mapsource
echo -
echo -  Map:  "MTB"
echo -  FID:  9999
echo -  PID:  2
echo -
echo -  Press Enter to continue or Ctrl-C to abort.
echo -
pause

if exist "%~dp0mapset.img" goto :INSTREG
echo Compiling preview map.
cgpsmapper "mapset.mp"
if exist "%~dp0mapset.img" goto :INSTREG
echo File missing: mapset.img, aborting install.
pause
exit 1

:INSTREG
echo Adding registry keys.

set KEY=HKLM\SOFTWARE\Wow6432Node\Garmin\MapSource
if %PROCESSOR_ARCHITECTURE% == AMD64 goto key_ok
set KEY=HKLM\SOFTWARE\Garmin\MapSource
:key_ok

reg ADD %KEY%\Families\FAMILY_9999 /v ID /t REG_BINARY /d 0F27 /f
if exist mapset_mdr.img (
	reg ADD %KEY%\Families\FAMILY_9999 /v IDX /t REG_SZ /d "%~dp0mapset.mdx" /f
	reg ADD %KEY%\Families\FAMILY_9999 /v MDR /t REG_SZ /d "%~dp0mapset_mdr.img" /f
)
reg ADD %KEY%\Families\FAMILY_9999 /v TYP /t REG_SZ /d "%~dp000000MTB.TYP" /f
reg ADD %KEY%\Families\FAMILY_9999\2 /v Loc /t REG_SZ /d "%~dp0\" /f
reg ADD %KEY%\Families\FAMILY_9999\2 /v Bmap /t REG_SZ /d "%~dp0mapset.img" /f
reg ADD %KEY%\Families\FAMILY_9999\2 /v Tdb /t REG_SZ /d "%~dp0mapset.tdb" /f
pause
exit 0
