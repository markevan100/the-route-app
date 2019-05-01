class WelcomeController < ApplicationController

  def home
    gon.mountain = Rails.application.credentials.mountain_secret
    gon.weather = Rails.application.credentials.weather_secret
    gon.map = Rails.application.credentials.map_secret
  end

  def test
    gon.cred = Rails.application.credentials.mountain_secret
  end

end
