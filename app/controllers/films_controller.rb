class FilmsController < ApplicationController

  before_action :validate_params, only: [:show]
  before_action :set_up_connector, only: [:index, :show]

  def index
    @star_wars_api_response = @star_wars_api.get Connectors::StarWarsConnector::INDEX_PATH
    parse_api_response
  end

  def show
    @star_wars_api_response = @star_wars_api.get Connectors::StarWarsConnector.show_path params[:id]
    parse_api_response
  end

  private

  def validate_params
    params.require(:id)

    if params[:id].to_i < 1 || params[:id].to_i > 7
      render json: { errors: { error: Errors::Messages.invalid_id_message(params[:id]) } }, status: 404
    end
  end

  def set_up_connector
    @star_wars_api = Connectors::StarWarsConnector.api
  end

  def parse_api_response

    if @star_wars_api_response.status != 200
      render json: { errors: { error: Errors::Messages::STAR_WARS_API_UNAVAILABLE } }, status: 503
      return
    end

    @response_data = JSON.parse(@star_wars_api_response.body)
  end

end
