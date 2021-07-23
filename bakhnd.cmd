Windows Registry Editor Version 5.00

;@echo off
;cls
;%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c%~s0 rem","","runas",1)(window.close)&&goto :eof
;cd /d %~dp0
;echo ==== Zetaspace Bak File Handler ====
;echo.
if not "%2%2"=="" goto :handler

;title .Bak File Handler Installing...
;echo [I] to install
;echo [R] to remove
;echo [C] to cancel
;echo.
;choice /c irc /n /m "Press...>"
;goto :to%errorlevel%>nul
;goto :eof
:to1
;reg import %~dpnx0
;reg add hkcr\backupfile\shell\open\command /ve /f /d "\"%~dpnx0\" rem \"%%1\""
;msg %username% /time:1 Done!
;goto :eof
:to2
;reg delete hkcr\.bak /f
;reg delete hkcr\backupfile /f
;msg %username% /time:1 Done!
;goto :eof

:handler
;title .Bak File Handler
;set bak=%2
;set ori="%bak:~1,-5%"
;echo Backup: %bak%
;echo Origin: %ori%
;echo.
;echo [U] to update  (file --^> .bak)
;echo [R] to restore (file ^<-- .bak)
;echo [X] to restore and delete
;echo [O] to open folder
;echo [C] to cancel
;echo.
;choice /c urxoc /n /m "Press...>"
;goto :h%errorlevel%>nul
;goto :eof
:h1
;if not exist %ori% echo Origin does not exist! Do nothing.&pause&goto :eof
;del %bak%
;copy %ori% %bak%
;goto :eof
:h2
;if exist %ori% del %ori%
;copy %bak% %ori%
;goto :eof
:h3
;if exist %ori% del %ori%
;copy %bak% %ori%
;del %bak%
;goto :eof
:h4
;for /f "delims=" %%i in ('echo %bak:~1,-1%') do set bakdir=%%~dpi
;mshta vbscript:CreateObject("Shell.Application").ShellExecute("%bakdir%","","","",0)(window.close)
;goto :eof

[HKEY_CLASSES_ROOT\.bak]
@="backupfile"
[HKEY_CLASSES_ROOT\backupfile]
@="Backup File"
[HKEY_CLASSES_ROOT\backupfile\shell]
[HKEY_CLASSES_ROOT\backupfile\shell\open]
[HKEY_CLASSES_ROOT\backupfile\shell\open\command]