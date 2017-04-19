class UsersController < ApplicationController
  def new
    # @user = User.new
    # redirect_to users_url
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password, :session_token)
  end
end
