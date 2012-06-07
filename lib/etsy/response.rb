module Etsy

  class OAuthTokenRevoked < StandardError; end
  class MissingShopID < StandardError; end
  class EtsyJSONInvalid < StandardError; end
  class TemporaryIssue < StandardError; end
  class InvalidUserID < StandardError; end

  # = Response
  #
  # Basic wrapper around the Etsy JSON response data
  #
  class Response

    # Create a new response based on the raw HTTP response
    def initialize(raw_response)
      @raw_response = raw_response
    end

    # Convert the raw JSON data to a hash
    def to_hash
      check_data!
      @hash ||= JSON.parse(data)
    end

    # Number of records in the response results
    def count
      if to_hash['pagination']
        to_hash['results'].nil? ? 0 : to_hash['results'].size
      else
        to_hash['count']
      end
    end

    # Results of the API request
    def result
      to_hash['results']
    end

    private

    def data
      @raw_response.body
    end

    def check_data!
      raise OAuthTokenRevoked if data == "oauth_problem=token_revoked"
      raise MissingShopID if data =~ /Shop with PK shop_id/
      raise InvalidUserID if data =~ /is not a valid user_id/
      raise TemporaryIssue if data =~ /Temporary Etsy issue|Resource temporarily unavailable|You have exceeded/
      raise EtsyJSONInvalid.new(data) unless valid_json?(data)
      true
    end

    def valid_json? json_
      JSON.parse(json_)
      return true
    rescue Exception => e
      return false
    end

  end
end
