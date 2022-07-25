@echo off
chcp 1252
SET LOGFILE=%USERNAME%-%date%-log.txt
SET HOSTIN=%SYSTEMDRIVE%\windows\system32\drivers\etc\hosts
SET HOSTOUT=%USERNAME%-hosts-%date%.txt
copy /Y %HOSTIN% %HOSTOUT%
defrag /A %* > %LOGFILE%
