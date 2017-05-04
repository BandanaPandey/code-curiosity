class Sponsorers::SessionsController < Devise::SessionsController
  def new
     super
     @sponsorer = Sponsorer.new
     authorize! :new, @sponsorer
   end

  # POST /resource/sign_in
   def create
     super
     authorize! :create, @sponsorer
   end
   def sign_up_params
    params.require(:sponsorer).permit(:email, :github_handle, :name)
  end
end