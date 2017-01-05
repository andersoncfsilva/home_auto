require 'sinatra'
require 'sinatra-websocket'
require 'pi_piper'
require 'json'
require 'yaml'

require_relative './home_auto'

set :public_folder, 'public'
set :server, 'thin'
set :sockets, []

config = YAML.load_file('config/config.yml')[settings.environment.to_s]
home_auto = HomeAuto.new(config['home_auto'])

get '/' do
  if !request.websocket?
    @dimmers = home_auto.dimmers
    @switches = home_auto.switches
    @title = 'Home Auto'
    erb :index
  else
    request.websocket do |ws|
      ws.onopen do
        ws.send('{"message": "Hello World!"}')
        settings.sockets << ws
      end
      ws.onmessage do |msg|
        EM.next_tick { settings.sockets.each { |s| s.send(msg) } }
      end
      ws.onclose do
        warn('websocket closed')
        settings.sockets.delete(ws)
      end
    end
  end
end

post '/set_dimmer' do
  dimmer_value = params[:dimmer_value]
  dimmer_id = params[:dimmer_id]
  puts "Setting dimmer #{dimmer_id} in #{dimmer_value}"
end

post '/set_switch' do
  switch_id = params[:switch_id]
  switch_status = params[:switch_status]
  home_auto.set_switch(switch_id, switch_status)
  EM.next_tick { settings.sockets.each { |s| s.send(params.to_json) } }
  puts "Setting #{switch_id} to #{switch_status}"
end
