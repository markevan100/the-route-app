class WelcomeController < ApplicationController
  include HTTParty
  require 'open-uri'
  require 'nokogiri'

  def home

  end

  def index
  end

  def post
    route = Route.where(name: params[:name]).first
    @@id = route.route_id
    redirect_to welcome_yourroute_path
  end

  def yourroute
    route = HTTParty.get("https://www.mountainproject.com/data/get-routes?routeIds=#{@@id}&key=#{Rails.application.credentials.mountain_secret}")
    @name = route.parsed_response["routes"][0]["name"]
    @stars = route.parsed_response["routes"][0]["stars"]
    @rating = route.parsed_response["routes"][0]["rating"]
    @@route_image = route.parsed_response["routes"][0]["imgMedium"]
    @pitch = route.parsed_response["routes"][0]["pitches"]
    lat = route.parsed_response["routes"][0]["latitude"]
    lng = route.parsed_response["routes"][0]["longitude"]
    gon.latt = route.parsed_response["routes"][0]["latitude"]
    gon.lngg = route.parsed_response["routes"][0]["longitude"]

    weather = HTTParty.get("https://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lng}&units=imperial&APPID=#{Rails.application.credentials.weather_secret}")
    @temp = weather.parsed_response["main"]["temp"]
    @humidity = weather.parsed_response["main"]["humidity"]
    @wind = weather.parsed_response["wind"]["speed"]
    @description = weather.parsed_response["weather"][0]["description"]
    @image = @@route_image
  end

  def comments
    @image = @@route_image
    doc = Nokogiri::HTML(open("https://www.mountainproject.com/route/#{@@id}"))
    body = doc.css('.comment-body')
    @first = body.first.text.split(" \n")[0].strip
    @last = body.last.text.split(" \n")[0].strip
  end

end
