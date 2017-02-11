#!/bin/bash

cd /home/pi/HomeAuto/ruby

nohup sudo ruby app.rb -o 0.0.0.0 > output.log 2>&1 &

cd /home/pi/HomeAuto/python

nohup python fauxmo.py > output.log 2>&1 &
