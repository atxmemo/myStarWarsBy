class FilmsController < ApplicationController

  before_action :validate_params, only: [:show]
  before_action :set_up_connector, only: [:index, :show]

  def index
    @star_wars_api_response = @star_wars_api.get '/api/films/'
    parse_api_response
  end

  def show
    @star_wars_api_response = @star_wars_api.get "/api/films/#{params[:id]}/"
    parse_api_response
  end

  private

  def validate_params
    params.require(:id)

    if params[:id].to_i < 1 || params[:id].to_i > 7
      render json: { errors: { error: "Id #{ params[:id] } is not a valid parameter. Valid parameters are 1 - 7 inclusive" } }, status: 404
    end
  end

  def set_up_connector
    @star_wars_api = Connectors::StarWarsConnector.api
  end

  def parse_api_response
    if @star_wars_api_response.status != 200
      render json: { errors: { error: 'StarWars API Service Unavailable, please check https://swapi.co/ for status' } }, status: 503
    end

    @response_data = JSON.parse(@star_wars_api_response.body)
  end

end
