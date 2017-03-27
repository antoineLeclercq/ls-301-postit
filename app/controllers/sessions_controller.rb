class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome #{user.username}. You are now logged in."
      redirect_to root_path
    else
      flash[:error] = 'The username and/or password entered are incorrect.'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You have logged out.'
    redirect_to posts_path
  end
end
