require 'sinatra'
require 'yaml'

require_relative './home_auto'

set :public_folder, 'public'
set :server, 'thin'
set :sockets, []

config = YAML.load_file('../config/config.yml')
home_auto = HomeAuto.new(config)

get '/' do
  @dimmers = home_auto.dimmers
  @switches = home_auto.switches
  @root_topic = config['mqtt']['root_topic']
  @broker_host = config['mqtt']['host']
  @broker_ws_port = config['mqtt']['ws_port']
  erb :index
end
