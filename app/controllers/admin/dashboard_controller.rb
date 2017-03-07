class Admin::DashboardController < ApplicationController
  before_filter(:only => [:index]) { authorize! :index, :dashboard }
  before_action :authenticate_user!
  before_action :authenticate_admin!

  def index
  end
end
