class SessionsController < ApplicationController
  def new
  end

  def create
  	submitted_user = params[:user]
  	user = User.find_by(username: submitted_user[:username])
  	if user && user.authenticate(submitted_user[:password])
  		session[:user_id] = user.id
  		redirect_to :root, notice: 'Logged in successfully'
  	else
  		redirect_to :login, alert: 'Invalid Login'
  	end
  end

  def destroy
  	reset_session
  	redirect_to :login, notice: 'Logged out successfully'
  end
end
