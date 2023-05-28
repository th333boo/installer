$HEADER="### ### ### ### ### ###
### Managed by BBI WEBSEC ###
### ### ### ### ### ###"

echo $HEADER

### [ DISABLE IPV6 ALL CARD ] ###
Disable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6

### [ SET ENV VARIABLES RULES ] ###
[Environment]::SetEnvironmentVariable("USERPROFILE", "C:\Users\user\", "User")

winget install -e --id=Python.Python.3.11 --source winget --silent --accept-package-agreements
python.exe -m pip install --upgrade pip
python.exe -m pip install -r requirements.txt

