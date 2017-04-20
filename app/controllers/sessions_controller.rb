class SessionsController < ApplicationController

  before_action :redirect_if_logged_in, only:[:new, :create]


  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])

    if @user
      login(@user)
    else
      redirect_to new_session_url
    end
  end

  def destroy
    # current_user.reset_session_token!
    # session[:session_token] = nil
    logout(current_user)
    redirect_to new_session_url
  end

  def redirect_if_logged_in
    if current_user
      redirect_to cats_url
    end
  end
end
