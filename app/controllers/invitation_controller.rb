class InvitationController < ApplicationController
  def index
    @total_confirmed_for_me = current_user.confirmed_for_me.order(:id)
    @available_confirmed_for_me = @total_confirmed_for_me.slice(0, @total_confirmed_for_me.size+current_user.rating)
  end

  def update
    Confirmation.find(params[:id]).update used:true
  end

end
