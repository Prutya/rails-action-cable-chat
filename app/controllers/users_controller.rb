class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: %i[new create]
  before_action :redirect_authenticated, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params_create)

    if @user.save
      sign_in(@user)
      display_flash(:success, 'Successfully signed up')
      return redirect_to root_path
    end

    display_flash(:error, 'Error signing up', now: true)
    render 'new'
  end

  private

  def params_create
    params.require(:user).permit(:username, :password)
  end
end
