module Connectors
  class StarWarsConnector

    def self.api
      Faraday.new(url: 'https://swapi.co') do |faraday_configuration|
        faraday_configuration.adapter  Faraday.default_adapter
        faraday_configuration.headers['Content-Type'] = 'application/json'
      end
    end

  end
end