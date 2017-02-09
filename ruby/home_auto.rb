class HomeAuto
  def initialize(config)
    @config = config
    @pins = []
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
    dimmers.find { |h| h[:id] == id }
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
    switches.find { |h| h[:id] == id }
  end

  def get_pin(pin)
    @pins[pin] = PiPiper::Pin.new(pin: pin, direction: :out) unless @pins[pin]
    @pins[pin]
  end

  def set_switch(id, status)
    pin = find_switch(id)[:pin]
    pi_pin = get_pin(pin)

    if status == 'true'
        pi_pin.on
    elsif status == 'false'
        pi_pin.off
    else
      raise "invalid switch status: #{status}"
    end
  end
end
