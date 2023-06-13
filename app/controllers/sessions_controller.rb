class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_or_create_by(uuid: params[:uuid])
    if user
      user.update last_used: Time.now
      session[:user_id] = user.id
      redirect_to home_path
    else
      render "new"
    end
  end

  def destroy
    session.clear
    redirect_to root_url, notice: :logged_out_notice
  end
end
