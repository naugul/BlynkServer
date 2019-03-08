#! /bin/bash
#Stop, Update and Start Blynk Server

#
#
#
#
#Service file can be found on /etc/init.d/blynk
#Cron job, daily, can be found on /etc/cron.daily/udpateBlynk as a symbolic lynk
#
#
#
#
#

cd /blynk

url=$(curl -s https://api.github.com/repos/blynkkk/blynk-server/releases/latest | grep 'browser_' | cut -d\" -f4)

strindex() {
  x="${1%%$2*}"
  [[ $x = $1 ]] && echo -1 || echo ${#x}
}

pos=$(strindex "$url" server-)

current=$(ls |  grep 'server' | grep 'jar')
new=${url:${pos}}

if [ "$current" == "$new" ]
then
	echo No update available...
else
	echo Update available!
	if [ -n "$current" ]
	then
		echo Deleting old version...
		rm $current
	fi
	echo Downlading version $new
	wget $(curl -s https://api.github.com/repos/blynkkk/blynk-server/releases/latest | grep 'browser_' | cut -d\" -f4)
	echo Stopping Blynk Service...
	service blynk stop
	echo Blynk Service Stopped!
	echo Starting Blynk Service...
	service blynk start
	echo Blynk Service Started!
fi
