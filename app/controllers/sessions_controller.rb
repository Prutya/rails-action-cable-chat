class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: %i[new create]
  before_action :redirect_authenticated, only: %i[new create]

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])

    if user && user.authenticate(params[:session][:password])
      sign_in(user)
      display_flash(:info, 'Signed in successfully')
      return redirect_to(root_path)
    end

    display_flash(:danger, 'This username/password combination does not exist', now: true)
    render 'new'
  end

  def destroy
    session[:user_id] = nil
    display_flash(:info, 'Signed out successfully')
    redirect_to new_session_path
  end
end
