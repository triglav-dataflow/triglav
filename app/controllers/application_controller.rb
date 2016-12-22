class ApplicationController < ActionController::API

  before_action :set_operator
  after_action  :set_access_log_info

  def set_operator
    RecordWithOperator.operator = current_user
  end

  def current_access_token
    request.env['HTTP_AUTHORIZATION']
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    if @current_user.present?
      @current_user
    elsif access_token = current_access_token
      @current_user = User.find_by_access_token(access_token)
    else
      @current_user = nil
    end
  end

  def authenticate!
    if current_user.present?
      true
    else
      raise Triglav::Error::InvalidAuthenticityToken
    end
  end

  def set_access_log_info
    info = {}
    info[:controller] = params[:controller]
    info[:user_name]  = current_user.name if current_user
    request.env['triglav_access_log'] = info
    # access_log is written by Triglav::Rack::AccessLogger rack middleware. See lib/triglav/rack/access_logger
  end

  # Error Handle

  def routing_error
    raise ActionController::RoutingError, "No route matches #{request.path.inspect}"
  end

  rescue_from StandardError, with: :rescue_exception

  private
    def rescue_exception(e)
      @exception = e

      response = { error: e.message.present? ? e.message : e.class.name }

      status_code =
          case e
          when ActiveRecord::RecordNotFound; 400
          when ActiveRecord::RecordNotUnique; 400
          when ActiveRecord::RecordInvalid; 400
          when JSON::ParserError; 400
          when Triglav::Error::StandardError; e.code
          else; ActionDispatch::ExceptionWrapper.new(env, e).status_code
          end

      if Rails.env.development? or Rails.env.test?
        response[:backtrace] = e.backtrace 
      end

      log_exception(e)
      render :json => response, status: status_code
    end

    def log_exception(e)
      case e
      when Triglav::Error::InvalidAuthenticityCredential
      when Triglav::Error::InvalidAuthenticityToken
      when ActiveRecord::RecordNotFound
      when ActiveRecord::RecordInvalid
      when JSON::ParserError
      when ActionController::RoutingError
      when ActionController::InvalidAuthenticityToken
      when ActionDispatch::ParamsParser::ParseError
      else
        Rails.logger.error e
      end
    end

end
