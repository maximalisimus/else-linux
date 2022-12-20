@echo off
if "%1" == "-rf" (
	if exist %2\ (
		rd /S /Q %2
	) else if exist %2 (
		del /F %2
	)
)
