# frozen_string_literal: true

class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  helper_method :current_user, :logged_in?

  inertia_share do
    {
      auth: {
        user: current_user&.as_json(only: %i[id uid email name slack_id]),
        logged_in: logged_in?
      }
    }
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def authenticate!
    redirect_to "/auth/login" unless logged_in?
  end
end
