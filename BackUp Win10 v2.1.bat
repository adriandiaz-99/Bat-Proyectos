-----------------------------------------------------------------------------------------------------

@echo off
title Backing Up Files...
color 87

set BV=C:\Users\Administrador\Desktop\destino

set EXC= TEMP CACHE COOKIES TMP


set BTTL=366

echo.
echo  Initializing, please wait...
echo.

dir %BV%

if not exist "%BV%" (
    title Backup Process Failed
    color C0
    echo.
    echo.
    echo.
    echo.
    echo   The backup volume, %BV%, appears to be inaccessible.  You may not perform
    echo   a backup at this time.
    echo.
    echo.
    echo.
    echo.
    pause
    exit
)


FOR /F "TOKENS=1,2,3* delims=/ " %%A IN ('DATE/T') DO SET MES=%%C
FOR /F "TOKENS=1,2* delims=/ " %%A IN ('DATE/T') DO SET DIA=%%B
FOR /F "TOKENS=1,2,3* delims=/ " %%A IN ('DATE/T') DO SET YEAR=%%D
for /f "tokens=1,2,3 delims=: " %%A in ('TIME /T') do set HORA=%%A;%%B%%C

IF %MES% == 01 (SET MES=Enero
 goto :begin)
IF %MES% == 02 (SET MES=Febrero
 goto :begin)
IF %MES% == 03 (SET MES=Marzo
 goto :begin)
IF %MES% == 04 (SET MES=April
 goto :begin)
IF %MES% == 05 (SET MES=Mayo
 goto :begin)
IF %MES% == 06 (SET MES=Junio
 goto :begin)
IF %MES% == 07 (SET MES=Julio
 goto :begin)
IF %MES% == 08 (SET MES=Agosto
 goto :begin)
IF %MES% == 09 (SET MES=Septembre
 goto :begin)
IF %MES% == 10 (SET MES=Octubre
 goto :begin)
IF %MES% == 11 (SET MES=Noviembre
 goto :begin)
IF %MES% == 12 (SET MES=Diciembre
 goto :begin)


:begin

IF %DIA% LEQ 31 SET SEMANA=Cuarta
IF %DIA% LEQ 21 SET SEMANA=Tercera
IF %DIA% LEQ 14 SET SEMANA=Segunda
IF %DIA% LEQ 07 SET SEMANA=Primera

echo.
echo.
echo.
echo   Beginning backup process, please wait...
echo.
echo.
echo.


if exist "%BV%" (
    forfiles /p %BV% /d -%BTTL% /c "CMD /Q /C @rmdir /S /Q @PATH"
    forfiles /p %BV% /d -%BTTL% /c "CMD /Q /C del /F /Q @PATH"
    cls
)


if exist "%BV%\%MES%_%YEAR%_Listo" (
    echo.
    echo.
    echo  Performing incremental backup...
    echo.
    echo.
    mkdir "%BV%\%DIA%_%MES%_%YEAR%_%HORA%_Incremental"
    set BLOG=%BV%\%DIA%_%MES%_%YEAR%_%HORA%_IncrementalBackupLog.txt
    robocopy C:\Users\Administrador\Desktop\origen "%BV%\%DIA%_%MES%_%YEAR%_%HORA%_Incremental" /B /E /M /R:0 /V /NP /TEE /XJ /LOG+:"%BV%\%DIA%_%MES%_%YEAR%_%HORA%_IncrementalBackupLog.txt" /XD %EXC%
) else (
    echo.
    echo.
    echo  Performing complete backup...
    echo.
    echo.
    set BLOG=%BV%\%MES%_%YEAR%_CompleteBackupLog.txt
    robocopy C:\Users\Administrador\Desktop\origen "%BV%\%MES%_%YEAR%_Listo" /B /E /R:0 /CREATE /NP /TEE /XJ /LOG+:"%BV%\%MES%_%YEAR%_ListoBackupLog.txt" /XD %EXC%
    robocopy C:\Users\Administrador\Desktop\origen "%BV%\%MES%_%YEAR%_Listo" /B /E /R:0 /V /NP /TEE /XJ /LOG+:"%BV%\%MES%_%YEAR%_ListoBackupLog.txt" /XD %EXC%
attrib -A "C:\Users\Administrador\Desktop\origen" /S
    )
)

:end

exit

 