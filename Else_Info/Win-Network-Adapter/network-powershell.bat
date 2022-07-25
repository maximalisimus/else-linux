@echo off
chcp 1251 >nul
echo.
echo "ipconfig /flushdns"
echo "ipconfig /registerdns"
echo 'ipconfig /release "Ethernet"'
echo 'ipconfig /renew "Ethernet"'
echo "ipconfig /all"
echo "ipconfig /displaydns"
echo.
echo "Get-NetAdapter | format-list"
echo 'Disable-NetAdapter -Name "Ethernet" -Confirm:$false'
echo 'Enable-NetAdapter -Name "Ethernet" -Confirm:$false'
echo.
powershell.exe
pause
