require "functions_framework"
require "net/http"
require "json"

FunctionsFramework.http("getPrice") do |request|
  uri = URI('https://api.coindesk.com/v1/bpi/currentprice.json')
  api_response = JSON.parse(Net::HTTP.get(uri))
  value = api_response["bpi"]["USD"]["rate"]

  message = "Hi Sydney, the current BTC Price is: " + value
  return message
end
