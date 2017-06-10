#!/bin/bash
### BEGIN INIT INFO
# Provides:          home_auto_listener
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: home_auto listener
# Description:       Home control listener to send signal to GPIO
### END INIT INFO

cd /home/pi/home_auto/app

nohup sudo ruby workers/listener.rb 2>&1 &
