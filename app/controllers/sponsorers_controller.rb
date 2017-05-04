class SponsorersController < ApplicationController
  #before_action :authenticate_sponser!

  before_filter { authorize! :all, :sponsorers}
  
  def index
    @payments = current_user ? current_user.payments : current_sponsorer.payments
    @payments = @payments.page(params[:page])
    render layout: 'sponser'
  end

  def show
    @sponsorer = Sponsorer.find(params[:id])
    render layout: 'sponser'
  end
end
