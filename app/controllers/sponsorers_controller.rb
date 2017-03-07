class SponsorersController < ApplicationController
  #before_action :authenticate_sponser!

  before_filter(:only => [:index]) { authorize! :index, :sponsorers}
  
  def index
    render layout: 'sponser'
  end

end
