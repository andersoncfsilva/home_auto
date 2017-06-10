#!/bin/bash

cd /home/pi/HomeAuto/app

nohup sudo ruby app.rb -o 0.0.0.0 > output.log 2>&1 &

cd /home/pi/HomeAuto/alexa

nohup python fauxmo.py > output.log 2>&1 &
