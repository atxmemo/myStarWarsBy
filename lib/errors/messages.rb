module Errors
  class Messages

    STAR_WARS_API_UNAVAILABLE = 'StarWars API Service Unavailable, please check https://swapi.co/ for status'

    def self.invalid_id_message id
      "Id #{id} is not a valid parameter. Valid parameters are 1 - 7 inclusive"
    end

  end
end