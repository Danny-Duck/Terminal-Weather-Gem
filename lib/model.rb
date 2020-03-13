# frozen_string_literal: true

class Weather_data
  attr_reader :time, :summary, :temp
  def initialize(time, summary, temp)
    @time = time
    @temp = temp
    @summary = summary
  end

  def self.get_ip
    begin 
      URI('http://whatismyip.akamai.com').open.read
    rescue
      puts "help me"
    end
  end

  def self.coord(location)
    location == 'current'
    Geocoder.search(location).first.coordinates
  end

  def self.data(location)
    week = []
    coord = coord(location)
    weather_call = URI("https://api.darksky.net/forecast/b90bba0f6d3f8c2e3102c9b691f4803d/#{coord[0]},#{coord[1]}?exclude=currently,alerts,flags,hourly,minutely").open.read

    File.write('weekly_weather_data.json', weather_call)

    weat_data = JSON.parse(File.read('./weekly_weather_data.json'))

    weat_data.dig('daily', 'data').each do |i|
      summary = i['summary']
      temp = ((i['temperatureHigh'] - 32) * (5.0/9.0)).round(2).to_s + "°"
      time = Time.at(i['time'])
      a = Weather_data.new(time, summary, temp)
      week << a
    end
    week
  end
end
