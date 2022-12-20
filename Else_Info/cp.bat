@echo off
if "%1" == "-f" (
	if NOT "%2" == "" (
		if NOT "%3" == "" (
			copy /Y "%2" "%3"
		) else (
			echo Error! Please input paramter 3.
		)
	) else (
		echo Error! Please input paramter 2.
	)
) else (
	if NOT "%1" == "" (
		if NOT "%2" == "" (
			copy "%1" "%2"
		) else (
			echo Error! Please input paramter 2.
		)
	) else (
		echo Error! Please input paramter 1.
	)
)
