# frozen_string_literal: true

require_relative 'model.rb'
require_relative 'config.rb'

Prompt = TTY::Prompt.new
Box = nil

def day_creation(date, summary, temp)
  TTY::Box.frame date, summary, temp, padding: 1, align: :center
end

def location_prom
  system 'clear'
  a = Prompt.select('Show me the forecast of ', { 'my current location!' => 1, 'somewhere else:' => 2 })
  a == 1 ? WData.weather_array('current') : WData.weather_array(other_prom)
end

def other_prom
  print '> '
  gets.chomp
end

def length_prom(weather_data)
  a = Prompt.select('and I it want for', { 'today' => 1, 'the week' => 2 })
  weather_data.each do |i|
    print day_creation(i.time, i.summary, i.temp)
    a == 1 ? break : next
  end
end

def additional_info
  case Prompt.select('and?', { 'New location?' => 1, 'Additional info' => 2 })
  when 1
    interface
  when 2
    puts 'Additional info'
  else
    puts 'help error'
  end
end

def interface
  weather_array = location_prom
  length_prom(weather_array)
  additional_info
end

puts 'Welcome to the Weather App'
interface
puts 'thank you bye bye'
