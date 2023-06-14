class ConfirmsController < ApplicationController
  def show
  end

  def create
    @confirm = Confirmation.create(confirmed_by: current_user, confirmed_for: User.find_by_uuid(params[:user_uuid]), code: params[:uuid_confirmation_code])
    render 'show'
  end

  def next_to_confirm
    users ||= User.not_confirmed_by_user(current_user).active_within_a_week.without_user(current_user).order(rating: :desc)
    users ||= User.not_confirmed_by_user(current_user).without_user(current_user).order(rating: :desc)
    @user = users.first
  end
  helper_method :next_to_confirm
end
