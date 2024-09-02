#! /bin/bash
sudo lpadmin -x LJ2300-Ethernet > /dev/null 2>&1
# options are listed in the ppd file
sudo lpadmin -p LJ2300-Ethernet -m  lsb/usr/HP/hp-laserjet_2300_series-ps.ppd.gz -E -L "office"  -v socket://laserjet:9100 -o PageSize=letter -o HPOption_Duplexer=True -o InstalledMemory=48MB -o HPOption_Tray3=Tray3_500 -u deny:none
#


# Set default
sudo lpadmin -d LJ2300-Ethernet
