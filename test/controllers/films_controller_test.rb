require 'test_helper'
require 'webmock/minitest'

class FilmsControllerTest < ActionDispatch::IntegrationTest

  # Index

  test 'Happy path on index action' do
    swapi_index_success_data = file_data('swapi_index_success.json')
    stub_request(:any, Connectors::StarWarsConnector::BASE_URL+ Connectors::StarWarsConnector::INDEX_PATH).to_return(body: swapi_index_success_data, status: 200)

    get films_path

    # JBuilder wraps the swapi data in a response
    assert_equal ((JSON.parse(@response.body))['response']), JSON.parse(swapi_index_success_data)
  end

  test 'Graceful handling of StarWars API error on index action' do
    stub_request(:any, Connectors::StarWarsConnector::BASE_URL+ Connectors::StarWarsConnector::INDEX_PATH).to_return(status: 500)

    get films_path

    assert_equal JSON.parse(@response.body)['errors']['error'], Errors::Messages::STAR_WARS_API_UNAVAILABLE
  end

  # Show

  test 'Happy path on show action' do
    film_id = Random.new.rand 1...8
    swapi_show_success_data = file_data("swapi_show_success_data_#{film_id}.json")
    stub_request(:any, Connectors::StarWarsConnector::BASE_URL + Connectors::StarWarsConnector.show_path(film_id)).to_return(body: swapi_show_success_data, status: 200)

    get film_path film_id

    # JBuilder wraps the swapi data in a response
    assert_equal ((JSON.parse(@response.body))['response']), JSON.parse(swapi_show_success_data)
  end

  test 'Graceful handling of invalid parameters on show action' do
    film_id = Random.new.rand 1...8
    stub_request(:any, Connectors::StarWarsConnector::BASE_URL + Connectors::StarWarsConnector.show_path(film_id)).to_return(status: 500)

    get film_path film_id

    assert_equal JSON.parse(@response.body)['errors']['error'], Errors::Messages::STAR_WARS_API_UNAVAILABLE
  end

  test 'Graceful handling of StarWars API validation error on show action' do
    invalid_film_id = 0

    get film_path invalid_film_id

    assert_equal JSON.parse(@response.body)['errors']['error'], Errors::Messages.invalid_id_message(invalid_film_id)

  end


end
