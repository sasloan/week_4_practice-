class SearchController < ApplicationController
    def index
        @location = params[:location]

        conn_1 = Faraday.new(url: "https://developer.nrel.gov") do |faraday|
            faraday.headers["X-API-KEY"] = ENV["NREL_API_KEY"]
        end

        response_1 = conn_1.get("/api/alt-fuel-stations/v1/nearest.json?location=#{@location}&fuel_type=ELEC&limit=1")

        json_1 = JSON.parse(response_1.body, symbolize_names: true)
        @destination = json_1[:fuel_stations].first

        conn_2 = Faraday.new(url: "https://maps.googleapis.com")

        response_2 = conn_2.get("/maps/api/directions/json?origin=#{@location}&destination=#{@destination[:street_address]}&key=#{ENV["GOOGLE_MAPS_API_KEY"]}")
        json_2 = JSON.parse(response_2.body, symbolize_names: true)
        @distance = json_2[:routes].first[:legs].first[:steps]
    end
end