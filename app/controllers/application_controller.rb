class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    current_session = Session.find_by(session_token: session[:session_token])
    if current_session
      @current_user ||= Session.find_by(session_token: session[:session_token]).user
    else
      @current_user = nil
    end
  end

  def login(user)
    new_token = user.generate_session_token
    session[:session_token] = new_token
    Session.create(user_id: user.id, session_token: new_token)
    redirect_to cats_url
  end

  def logout(user)
    token = session[:session_token]
    Session.find_by(user_id: user.id, session_token: token).destroy
    session[:session_token] = nil
  end



end
