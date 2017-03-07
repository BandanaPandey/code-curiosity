class GoalsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    @goals = Goal.asc(:points)
  end
end
