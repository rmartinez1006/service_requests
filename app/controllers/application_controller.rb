class ApplicationController < ActionController::Base
  protect_from_forgery


  helper_method :current_user

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = Administration::UserSession.find
  end

  def current_user
	  return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def authorize
    unless current_user
      store_location
      flash[:notice] = "Es necesario iniciar la sesión como usuario."
      redirect_to administration_login_path
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end
end
