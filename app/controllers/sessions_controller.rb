class SessionsController < ApplicationController
  def new

  end

  def create
    uuid = Uuid.find_or_create_by(value: params[:uuid])
    user = User.find_or_create_by(uuid: uuid)
    if user
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
