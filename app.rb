require "functions_framework"
require "net/http"
require "json"

FunctionsFramework.http("getPrice") do |request|
  uri = URI('https://api.coindesk.com/v1/bpi/currentprice.json')
  response = JSON.parse(Net::HTTP.get(uri))
  return response["bpi"]["USD"]["rate"]
end
