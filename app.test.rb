require "minitest/autorun"
require "functions_framework/testing"
require 'webmock/minitest'

class Test < Minitest::Test
  include FunctionsFramework::Testing

  mocked_response = "{\"time\":{\"updated\":\"Jan 19, 2021 13:22:00 UTC\",\"updatedISO\":\"2021-01-19T13:22:00+00:00\",\"updateduk\":\"Jan 19, 2021 at 13:22 GMT\"},\"disclaimer\":\"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org\",\"chartName\":\"Bitcoin\",\"bpi\":{\"USD\":{\"code\":\"USD\",\"symbol\":\"&#36;\",\"rate\":\"37,036.3183\",\"description\":\"United States Dollar\",\"rate_float\":37036.3183},\"GBP\":{\"code\":\"GBP\",\"symbol\":\"&pound;\",\"rate\":\"27,216.1385\",\"description\":\"British Pound Sterling\",\"rate_float\":27216.1385},\"EUR\":{\"code\":\"EUR\",\"symbol\":\"&euro;\",\"rate\":\"30,542.4443\",\"description\":\"Euro\",\"rate_float\":30542.4443}}}"

  WebMock.stub_request(:get, "https://api.coindesk.com/v1/bpi/currentprice.json").
    to_return(body: mocked_response, status: 200)

  def test_bitcoin_price_ticker
    load_temporary "app.rb" do
      request = make_get_request("https://localhost")
      response = call_http("getPrice", request)

      assert_equal 200, response.status
      assert_equal "37,036.3183", response.body.join
    end
  end
end
