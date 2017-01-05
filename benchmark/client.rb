require 'triglav_client'

class Client
  class Error < StandardError
    attr_reader :cause
    def initialize(message, cause)
      @cause = cause
      super(message)
    end
  end
  class AuthenticationError < Error; end
  class ConnectionError < Error; end

  attr_reader :url, :username, :password, :authenticator

  def initialize(
    url: 'http://localhost:7800',
    username: 'triglav_test',
    password: 'triglav_test',
    authenticator: 'local',
    timeout: nil,
    debugging: nil
  )
    @url = url
    @username = username
    @password = password
    @authenticator = authenticator
    @timeout = timeout
    @debugging = debugging
    initialize_current_token
    authenticate
  end

  # Send messages
  #
  # @param [Array] events array of event messages
  #
  #   {
  #     resource_uri: "hdfs://host:port/path/to/resource",
  #     resource_unit: 'daily',
  #     resource_time: Time.at.to_i,
  #     resource_timezone: "+09:00",
  #     payload: {free: "text"}.to_json,
  #   }
  #
  # @see TriglavAgent::MessageRequest
  def send_messages(events)
    messages_api = TriglavClient::MessagesApi.new(api_client)
    handle_error { messages_api.send_messages(events) }
  end

  # Fetch messages
  #
  # @param [Integer] offset
  # @param [Integer] limit
  # @param [Array] resource_uris
  # @return [Array] array of messages
  # @see TriglavClient::MessageEachResponse
  #   id
  #   resource_uri
  #   resource_unit
  #   resource_time
  #   resource_timezone
  #   payload
  def fetch_messages(offset, limit: 100, resource_uris: [])
    messages_api = TriglavClient::MessagesApi.new(api_client)
    # fetch_request = TriglavClient::MessageFetchRequest.new.tap {|request|
    #   request.offset = offset
    #   request.limit = limit
    #   request.resource_uris = resource_uris
    # }
    # with_token { messages_api.fetch_messages(fetch_request) }
    handle_error { messages_api.list_messages(offset, {limit: limit, resource_uris: resource_uris}) }
  end

  private

  def api_client
    return @api_client if @api_client
    config = TriglavClient::Configuration.new do |config|
      uri = URI.parse(url)
      config.scheme = uri.scheme
      config.host = "#{uri.host}:#{uri.port}"
      config.timeout = @timeout if @timeout
      config.debugging = @debugging if @debugging
    end
    @api_client = TriglavClient::ApiClient.new(config)
  end

  # Authenticate
  #
  # 1. Another process saved a newer token onto the token_file => read it
  # 2. The token saved on the token_file is same with current token => re-authenticate
  # 3. The token saved on the token_file is older than the current token
  #   => unknown situation, re-authenticate and save into token_file to refresh anyway
  # 4. No token is saved on the token_file => authenticate
  def authenticate
    auth_api = TriglavClient::AuthApi.new(api_client)
    credential = TriglavClient::Credential.new(
      username: username, password: password, authenticator: authenticator
    )
    handle_auth_error do
      result = auth_api.create_token(credential)
      token = {access_token: result.access_token}
      update_current_token(token)
    end
  end

  def initialize_current_token
    @current_token = {
      access_token: (api_client.config.api_key['Authorization'] = String.new),
    }
  end

  def update_current_token(token)
    @current_token[:access_token].replace(token[:access_token])
  end

  def handle_auth_error(&block)
    begin
      yield
    rescue TriglavClient::ApiError => e
      if e.code == 0
        raise ConnectionError.new("Could not connect to #{triglav_url}", e)
      elsif e.message == 'Unauthorized'.freeze
        raise AuthenticationError.new("Failed to authenticate on triglav API.".freeze, e)
      else
        raise Error.new(e.message, e)
      end
    end
  end

  def handle_error(&block)
    begin
      yield
    rescue TriglavClient::ApiError => e
      if e.code == 0
        raise ConnectionError.new("Could not connect to #{triglav_url}", e)
      elsif e.message == 'Unauthorized'.freeze
        authenticate
        retry
      else
        raise Error.new(e.message, e)
      end
    end
  end
end
