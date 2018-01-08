class ApplicationController < ActionController::Base
  KEYS_FLASH = %i[error warning success info]

  protect_from_forgery with: :exception

  include SessionsHelper

  before_action :authenticate_user

  def authenticate_user
    return if signed_in?

    display_flash(:error, 'You are not signed in.')
    redirect_to new_session_path
  end

  def redirect_authenticated
    return unless signed_in?

    display_flash(:error, 'You are already signed in.')
    redirect_to root_path
  end

  protected

  def display_flash(key, message, now: false)
    if now
      flash.now[key] = [] if flash.now[key].nil?
      flash.now[key] = [flash.now[key]] unless flash.now[key].is_a?(Array)
      flash.now[key] << message
    else
      flash[key] = [] if flash[key].nil?
      flash[key] = [flash[key]] unless flash[key].is_a?(Array)
      flash[key] << message
    end
  end
end
