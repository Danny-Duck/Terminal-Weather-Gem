# frozen_string_literal: true

require_relative 'model.rb'
require 'open-uri'
require 'json'
require 'ipaddr'
require 'geocoder'
require 'csv'
require 'time'
require 'date'
require 'tty-prompt'
require 'tty-spinner'
require 'tty-box'

Prompt = TTY::Prompt.new
Box = nil

puts 'Welcome to the Weather App'

def day_creation(date, summary, temp)
  TTY::Box.frame date, summary, temp, padding: 1, align: :center
end

def location_prom
  a = Prompt.select('Show me the forecast of ', { 'my current location!' => 1, 'somewhere else:' => 2 })
  a == 1 ? Weather_data.data('current') : Weather_data.data(other_prom)
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

def again_prom
  interface if Prompt.yes?('Try another location?') == true
end

def interface
  weather_data = location_prom
  length_prom(weather_data)
  again_prom
end

system 'clear'
interface
puts 'thank you bye bye'
