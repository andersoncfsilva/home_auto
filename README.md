# Home Auto #

## Python dependencies ##
sudo python -m easy_install pyyaml

## Install Mosquitto (MQTT broker) with websockets ##

wget http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key
sudo apt-key add mosquitto-repo.gpg.key
cd /etc/apt/sources.list.d/
sudo wget http://repo.mosquitto.org/debian/mosquitto-jessie.list
sudo apt-get update
sudo apt-get install mosquitto

## /config ##
Config your smart devices here

## /app ##
A Sinatra web app to control the devices

## /app/workers ##
listener.rb
Ruby app to send signals to the GPIO interface

publisher.rb (optional)
Watch for events from a current sensor to know the state of a physical light

## /alexa ##
fauxmo.py script that simulates smart devices to work with Alexa

## /etc ##
config files for the services
