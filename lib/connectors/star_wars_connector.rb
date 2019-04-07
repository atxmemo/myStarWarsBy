module Connectors
  class StarWarsConnector

    BASE_URL = 'https://swapi.co'
    INDEX_PATH = '/api/films/'

    def self.api
      Faraday.new(url: BASE_URL) do |faraday_configuration|
        faraday_configuration.adapter  Faraday.default_adapter
        faraday_configuration.headers['Content-Type'] = 'application/json'
      end
    end

    def self.show_path id
      "/api/films/#{id}/"
    end

  end
end