class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.where(username: params[:username]).first

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You are logged in"
      redirect_to root_path
    else 
      flash[:error] = "There was a problem with your username or password"
      redirect_to login_path
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'You have been logged out'
    redirect_to root_path
  end
end