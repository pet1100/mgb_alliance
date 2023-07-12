class SessionsController < ApplicationController
  def new
    if cookies[:user_uuid]
      user = User.find_by(uuid: cookies[:user_uuid])
      user.update last_used: Time.now
      session[:user_id] = user.id
      redirect_to home_path
    end
  end

  def create
    user = User.find_or_create_by(uuid: params[:uuid])
    if user
      user.update last_used: Time.now
      cookies[:user_uuid] = user.uuid
      session[:user_id] = user.id
      redirect_to home_path
    else
      render "new"
    end
  end

  def destroy
    session.clear
    cookies.delete :user_uuid
    redirect_to root_url, notice: :logged_out_notice
  end
end
