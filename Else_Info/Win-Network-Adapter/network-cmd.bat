@echo off
chcp 1251 >nul
echo.
echo "ipconfig /flushdns"
echo "ipconfig /registerdns"
echo 'ipconfig /release "����������� �� ��������� ����"'
echo 'ipconfig /renew "����������� �� ��������� ����"'
echo "ipconfig /all"
echo "ipconfig /displaydns"
echo.
echo "netsh interface show interface"
echo 'netsh interface set interface "����������� �� ��������� ����" disable'
echo 'netsh interface set interface "����������� �� ��������� ����" enable'
echo 'netsh interface set interface name="����������� �� ��������� ����" admin=DISABLED'
echo 'netsh interface set interface name="����������� �� ��������� ����" admin=ENABLED'
echo.
cmd.exe
