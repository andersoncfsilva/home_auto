require 'yaml'
require 'mqtt'
require 'byebug'

require_relative '../home_auto.rb'

config_path = File.join(File.dirname(__FILE__), '../../config/config.yml')
config = YAML.load_file(config_path)

puts "Connecting to #{config['mqtt']['host']}:#{config['mqtt']['port']}"
client = MQTT::Client.connect(config['mqtt']['host'], config['mqtt']['port'])

puts "Subscribing to #{config['mqtt']['topic']}"
client.subscribe(config['mqtt']['topic'])

home_auto = HomeAuto.new(config)
puts "Listening..."

# Subscribe example
client.get do |topic, message|
  switch_id = topic.split('/').last
  puts "#{switch_id} #{message}"
  home_auto.set_switch(switch_id, message)
end
