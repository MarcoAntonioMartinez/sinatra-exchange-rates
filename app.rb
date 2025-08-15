require "sinatra"
require "sinatra/reloader"
require "json"
require "dotenv/load"
require "http"

get("/") do
  
  list_url = "https://api.exchangerate.host/list?access_key=" + ENV.fetch("EXCHANGE_RATE_KEY")

  #get response for location
  resp = HTTP.get(list_url)

  raw_response = resp.to_s

  parsed_response = JSON.parse(raw_response)

  @results = parsed_response.fetch("currencies").keys

  
  
  erb(:home)
  
 end





#exc_url = "https://https://api.exchangerate.host/convert?from=" + curr_from + "&to="  + curr_to  + "&amount=1&access_key=" + ENV.fetch("EXCHANGE_RATE_KEY") 
