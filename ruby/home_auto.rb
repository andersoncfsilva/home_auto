class HomeAuto
  def initialize(config)
    @config = config
  end

  def dimmers
    @config['dimmers'].map do |dimmer|
      {
        id: dimmer['id'],
        value: 50,
        name: dimmer['name']
      }
    end
  end

  def find_dimmer(id)
    dimmers.find{|h| h[:id] == id}
  end

  def switches
    @config['switches'].map do |switch|
      {
        id: switch['id'],
        status: true,
        name: switch['name'],
        pin: switch['pin_num']
      }
    end
  end

  def find_switch(id)
    switches.find{|h| h[:id] == id}
  end

  def set_switch(id, status)
    pi_pin = PiPiper::Pin.new(:pin => find_switch(id)[:pin], :direction => :out)
    case status
    when 'true'
      pi_pin.on
    when 'false'
      pi_pin.off
    else
      raise "invalid switch status: #{status}"
    end
  end

end
