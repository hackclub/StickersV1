# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_forgery_protection only: :callback

  def login
    redirect_to "/auth/oidc", allow_other_host: true
  end

  def callback
    auth = request.env["omniauth.auth"]
    user = User.from_omniauth(auth)
    session[:user_id] = user.id
    redirect_to ENV.fetch("AUTH_SUCCESS_REDIRECT", "/stickers")
  end

  def logout
    session.clear
    redirect_to ENV.fetch("AUTH_LOGOUT_REDIRECT", "/")
  end

  def me
    if current_user
      render json: {
        id: current_user.id,
        uid: current_user.uid,
        email: current_user.email,
        name: current_user.name,
        slack_id: current_user.slack_id
      }
    else
      head :unauthorized
    end
  end

  def failure
    redirect_to "/", alert: "Authentication failed: #{params[:message]}"
  end
end
