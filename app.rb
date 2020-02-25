require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"

def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

ForecastIO.api_key = "f8e36e3c21fe208b28c8a82b2f345e9e"

get "/" do
  view "ask"
end

get "/news" do
  @location = params["location"]
  @geocode = Geocoder.search(@location)
  
  @geocode_lat = @geocode.first.coordinates[0]
  @geocode_long = @geocode.first.coordinates[1]

  @geocode_country = @geocode.first.country

  forecast = ForecastIO.forecast(@geocode_lat, @geocode_long).to_hash

  @current_temperature = forecast["currently"]["temperature"] 
  @current_summary = forecast["currently"]["summary"].downcase

  @forecast_daily = forecast["daily"]["data"]
  

  url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=0fff2bcef975458089b6fcc5bfcc7dee"
  news = HTTParty.get(url).parsed_response.to_hash

  @news_title_1 = news["articles"][0]["title"]
  @news_description_1 = news["articles"][0]["description"]
  @news_url_1 = news["articles"][0]["url"]
  
  @news_title_2 = news["articles"][1]["title"]
  @news_description_2 = news["articles"][1]["description"]
  @news_url_2 = news["articles"][1]["url"]

  @news_title_3 = news["articles"][2]["title"]
  @news_description_3 = news["articles"][2]["description"]
  @news_url_3 = news["articles"][2]["url"]

  @news_title_4 = news["articles"][3]["title"]
  @news_description_4 = news["articles"][3]["description"]
  @news_url_4 = news["articles"][3]["url"]
  
  @news_title_5 = news["articles"][4]["title"]
  @news_description_5 = news["articles"][4]["description"]
  @news_url_5 = news["articles"][4]["url"]

  view "news"

end