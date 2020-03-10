require "open-uri"
require "json"
require "geocoder"

result = Geocoder.search("busselton, australia")
results = result.first.coordinates
pp results
x = results[0]
y = results[1]

weather_call = URI("https://api.darksky.net/forecast/b90bba0f6d3f8c2e3102c9b691f4803d/#{x},#{y}").open.read

pp weather_call
