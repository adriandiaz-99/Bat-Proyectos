@ECHO OFF
rem MODE con:lines=30
SETLOCAL EnableDelayedExpansion

TITLE MEE INFORMATICA 4367-6264 - INTERNO 359
SET /A "cc=0"
COLOR 1A
CLS

:: INICIAR MAXIMIZADO
IF NOT "%1" == "max" START /MAX cmd /c %0 max & EXIT/b

rem FOR %A in (fichero) do set size=%~zA

ECHO. & SET /A "cc+=1" && ECHO [!cc!] NOMBRE COMPUTADORA: !COMPUTERNAME!

ECHO. & SET /A "cc+=1" && SET /P nada=[!cc!] SISTEMA OPERATIVO: < NUL
FOR /f "tokens=3*" %%i IN ('REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName ^| Find "ProductName"') DO SET vers=%%i %%j

ECHO %vers% | FIND "XP"
if %ERRORLEVEL% == 0 (
		SET buscarIP="ip."
	) ELSE (
		SET /P nada=!vers! de< NUL & WMIC OS get OSArchitecture | FIND "bits"
		SET buscarIP="ipv4"
	)
	
ECHO. & SET /A "cc+=1" && ECHO [!cc!] IPs: & CALL :obtenerINFO "IPCONFIG /ALL" !buscarIP!

ECHO. & SET /A "cc+=1" && ECHO [!cc!] DHCP Habilitado: & CALL :obtenerINFO "IPCONFIG /ALL" "DHCP habilitado"

ECHO. & SET /A "cc+=1" && SET /P nada=[!cc!] D-WARE: < NUL
IF EXIST "%windir%\dwrcs" (ECHO Instalado) ELSE (ECHO No hallado)

ECHO. & SET /A "cc+=1" && SET /P nada=[!cc!] USER:< NUL & ECHO !USERNAME!

ECHO. & SET /A "cc+=1" && ECHO [!cc!] DIRECCIONES MAC: & CALL :obtenerINFO "IPCONFIG /ALL" "sica"

FOR /f "tokens=3*" %%i IN ('REG QUERY "HKLM\SYSTEM\ControlSet001\services\Tcpip\Parameters" /v Domain ^| Find "Domain"') DO SET dominio=%%i
IF /I '!dominio!' NEQ '' (ECHO. & SET /A "cc+=1" & ECHO [!cc!] DOMINIO: !dominio!)

ECHO.

for /l %%x in (1, 1, 50) do (
	pause > nul
	set /a numA=!random! %% 8
	set /a numB=!random! %% 8
	color !numA!!numB!
)

PAUSE>NUL

EXIT
:obtenerINFO
SET "output_cnt=0"
SET AUX=
FOR /F "tokens=*" %%i IN ('%~1 ^| FINDSTR /I /C:"%~2"') DO (
	SET /a output_cnt+=1
	SET "AUX[!output_cnt!]=%%i"
)
FOR /L %%n IN (1 1 !output_cnt!) DO (ECHO     !AUX[%%n]:* : =!)
ENDLOCAL