class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :already, only: [:new, :create]

  def new
    @membership = Membership.new
    @m = nil
  end

  def create
    @membership = Membership.new(membership_params)
    if @membership.valid?
      if total_payment(current_user).between?(30000, 49999)
        @membership.rank_id = 1
      elsif total_payment(current_user).between?(50000, 99999)
        @membership.rank_id = 2
      elsif total_payment(current_user) >= 100000
        @membership.rank_id = 3
      end
      @membership.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def membership_params
    params.require(:membership).permit(:image, :appeal, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(user_id: current_user.id)
  end

  def already
    redirect_to root_path if current_user.membership
  end
end
