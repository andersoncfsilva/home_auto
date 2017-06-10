#!/bin/bash
### BEGIN INIT INFO
# Provides:          home_auto_web
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: home_auto web
# Description:       Home control web interface
### END INIT INFO

cd /home/pi/home_auto/app

nohup ruby app.rb -o 0.0.0.0 2>&1 &
