class MembershipsController < ApplicationController
  def new
    @membership = Membership.new
  end

  def create
    @membership = Membership.new(membership_params)
    if @membership.valid?
      @membership.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def membership_params
    params.require(:membership).permit(:appeal, :postal_code, :prefecture, :city, :addresses, :building, :phone_number).merge(user_id: current_user.id)
  end
end
