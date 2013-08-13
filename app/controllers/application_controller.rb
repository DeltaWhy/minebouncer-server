class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  def authenticate
    if user = authenticate_with_http_basic { |u, p| (user = User.find_by_email(u)) && user.authenticate(p) }
      @current_user = user
    else
      request_http_basic_authentication
    end
  end

  def current_user
    @current_user
  end
end
