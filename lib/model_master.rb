# frozen_string_literal: true

class WData
  attr_reader :time, :summary, :temp
  def initialize(time, summary, temp)
    @time = time
    @temp = temp
    @summary = summary
  end

  def self.temp_conversion(faren)
    ((faren.to_i - 32) * (5.0 / 9.0)).round(2).to_s + '°'
  end

  def self.ip
    URI('http://whatismyip.akamai.com').open.read
  end

  def self.data_update(location)
    location == 'current' ? location = ip : nil
    p coord = Geocoder.search(location).first.coordinates
    api_call = URI("https://api.darksky.net/forecast/b90bba0f6d3f8c2e3102c9b691f4803d/#{coord[0]},#{coord[1]}?exclude=currently,alerts,flags,hourly,minutely").open.read
    File.write('weather_data.json', api_call)
  end

  def self.weather_array(location)
    arr = []
    data_update(location)
    weat_data = JSON.parse(File.read('./weather_data.json'))
    weat_data.dig('daily', 'data').each do |i|
      summary = i['summary']
      temp = temp_conversion(i['temperatureHigh'])
      time = Time.at(i['time'])
      day = WData.new(time, summary, temp)
      arr << day
    end
   arr
  end
end
