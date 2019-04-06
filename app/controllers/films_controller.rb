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
    @response_data = JSON.parse(@star_wars_api_response.body)
  end

end
