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
Box =

  puts 'Welcome to the Weather App'

def day_creation(date, summary, temp)
  TTY::Box.frame date, summary, temp, padding: 1, align: :center
end

def local_prom
  Prompt.select('Show me the forecast of ', { 'my current location!' => 1, 'somewhere else:' => 2 }, default: 1)
end

def other_prom
  print '> '
  gets.chomp
end

def time_prom
  Prompt.select('and I it want for', { 'today' => 1, 'the week' => 2 })
end

def again_prom
  interface if Prompt.yes?('Try another location?') == true
end

def interface
  print Box
  week = []
  week = if local_prom == 1
           Weather_data.data('current')
         else
           Weather_data.data(other_prom)
           end
  if time_prom == 1
    print day_creation(week[0].time, week[0].summary, week[0].temp)
  else
    week.each do |i|
      print day_creation(i.time, i.summary, i.temp)
    end
  end
  again_prom
end

system 'clear'
interface
puts 'thank you bye bye'
