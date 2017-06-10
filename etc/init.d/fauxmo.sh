#!/bin/bash
### BEGIN INIT INFO
# Provides:          fauxmo
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: fauxmo
# Description:       simulates smart devices for use with Alexa
### END INIT INFO

cd /home/pi/home_auto/alexa

nohup python fauxmo.py 2>&1 &
