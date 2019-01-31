class SessionsController < ApplicationController
  before_action :require_current_user!, only: [:create, :new]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if user
      login_user!(user)
      redirect_to cats_url
    else
      flash[:errors] = ["Username or Password incorrect. Figure out which bitch."]
      redirect_to new_session_url
    end
  end

  def destroy
    logout_user!
    redirect_to new_session_url
  end
end
