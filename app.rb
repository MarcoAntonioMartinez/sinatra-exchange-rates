require "sinatra"
require "sinatra/reloader"
require "json"
require "dotenv/load"
require "http"

get("/") do

@results = api_list
  erb(:home)
  
end

get("/:currency") do

  @currency = params.fetch("currency")

  @results = api_list

  erb(:to)

end

get("/:curr_from/:curr_to") do

  @curr_from = params.fetch("curr_from")
  @curr_to = params.fetch("curr_to")

  exc_url = "https://api.exchangerate.host/convert?from=" + @curr_from + "&to="  + @curr_to  + "&amount=1&access_key=" + ENV.fetch("EXCHANGE_RATE_KEY") 

#get response for exchange of currency
  resp = HTTP.get(exc_url)

  raw_response = resp.to_s

  parsed_response = JSON.parse(raw_response)

  @result = parsed_response.fetch("result")

  erb(:exchange)
end


def api_list 

list_url = "https://api.exchangerate.host/list?access_key=" + ENV.fetch("EXCHANGE_RATE_KEY")

  #get response for list of currency
  resp = HTTP.get(list_url)

  raw_response = resp.to_s

  parsed_response = JSON.parse(raw_response)

  results = parsed_response.fetch("currencies").keys
end
