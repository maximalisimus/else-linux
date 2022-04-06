@echo off
chcp 1251 >nul
echo.
echo "ipconfig /flushdns"
echo "ipconfig /registerdns"
echo 'ipconfig /release "Подключение по локальной сети"'
echo 'ipconfig /renew "Подключение по локальной сети"'
echo "ipconfig /all"
echo "ipconfig /displaydns"
echo.
echo "netsh interface show interface"
echo 'netsh interface set interface "Подключение по локальной сети" disable'
echo 'netsh interface set interface "Подключение по локальной сети" enable'
echo 'netsh interface set interface name="Подключение по локальной сети" admin=DISABLED'
echo 'netsh interface set interface name="Подключение по локальной сети" admin=ENABLED'
echo.
cmd.exe
