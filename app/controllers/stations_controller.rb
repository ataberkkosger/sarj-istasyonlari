require "net/http"
require "json"

class StationsController < ApplicationController
  def index
    url = URI("https://api.openchargemap.io/v3/poi/?output=json&countrycode=TR&maxresults=2000&key=YOUR_API_KEY")
    response = Net::HTTP.get(url)
    api_response = JSON.parse(response)

    @api_stations = api_response

    @custom_stations = ChargingStation.all
  end

  def create
    @station = ChargingStation.new(station_params)

    if @station.save
      redirect_to root_path, notice: "Yeni istasyon başarıyla eklendi."
    else
      redirect_to root_path, alert: "İstasyon eklenemedi: #{@station.errors.full_messages.join(', ')}"
    end
  end

  private

  def station_params
    params.require(:charging_station).permit(:title, :latitude, :longitude)
  end
end
