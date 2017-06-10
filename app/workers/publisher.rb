require 'pi_piper'
include PiPiper


watch pin: 22 do
  puts "Pin 22 changed from #{last_value} to #{value}"
end

watch pin: 27 do
  puts "Pin 27 changed from #{last_value} to #{value}"
end
