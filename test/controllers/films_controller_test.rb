require 'test_helper'
require 'webmock/minitest'

class FilmsControllerTest < ActionDispatch::IntegrationTest

  # Index

  test 'Graceful handling of StarWars API error on index action' do
    stub_request(:any, Connectors::StarWarsConnector::BASE_URL+ Connectors::StarWarsConnector::INDEX_PATH).to_return(status: 500)

    get films_path

    assert_equal JSON.parse(@response.body)['errors']['error'], Errors::Messages::STAR_WARS_API_UNAVAILABLE
  end

  # Show

  test 'Graceful handling of invalid parameters on show action' do
    film_id = Random.new.rand 1...8
    stub_request(:any, Connectors::StarWarsConnector::BASE_URL + Connectors::StarWarsConnector.show_path(film_id)).to_return(status: 500)

    get film_path film_id

    assert_equal JSON.parse(@response.body)['errors']['error'], Errors::Messages::STAR_WARS_API_UNAVAILABLE
  end

  test 'Graceful handling of StarWars API error on show action' do
    invalid_film_id = 0

    get film_path invalid_film_id

    assert_equal JSON.parse(@response.body)['errors']['error'], Errors::Messages.invalid_id_message(invalid_film_id)

  end


end
