require 'yaml'
require 'mqtt'

require_relative '../home_auto.rb'

config_path = File.join(File.dirname(__FILE__), '../../config/config.yml')
config = YAML.load_file(config_path)

mqtt_host = config['mqtt']['host']
mqtt_port = config['mqtt']['port']
root_topic = config['mqtt']['root_topic']

puts "Connecting to #{mqtt_host}:#{mqtt_port}"
client = MQTT::Client.connect(mqtt_host, mqtt_port)

puts "Subscribing to #{root_topic}"
client.subscribe("#{root_topic}/#")

home_auto = HomeAuto.new(config)
puts "Listening..."

# Subscribe example
client.get do |topic, message|
  switch_id = topic.split('/').last
  puts "#{switch_id} #{message}"
  home_auto.set_switch(switch_id, message)
end
