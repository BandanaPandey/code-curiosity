class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :signout_old_login, :select_goal
  before_action :current_round
  helper_method :current_round

  #check_authorization
  rescue_from CanCan::AccessDenied do |exception|
    flash[:warning] = exception.message
    if current_user && current_user.current_role == 'Sponsorer'
      redirect_to sponsorers_path
    else
      redirect_to root_path
    end
  end

  protected

  def current_round
    @rounds = Round.order(from_date: :desc).limit(3)
    @current_round = if session[:current_round]
                       Round.find(session[:current_round])
                     else
                       Round.find_by({status: 'open'})
                     end
  end

  def signout_old_login
    if current_user && current_user.auth_token.blank?
      sign_out current_user
      redirect_to root_path
      return false
    end
  end

  def select_goal
    return true unless current_user
    return true if params[:controller] == 'goals' && params[:action] == 'index'
    return true if params[:action] == 'set_goal' || params[:controller] == 'devise/sessions'
    return true if current_user.is_admin?
    return true if current_user.is_sponsorer?

    if current_user.goal.blank?
      redirect_to goals_path, notice: I18n.t('goal.please_select')
    end
  end

  def authenticate_judge!
    unless current_user.is_judge
      redirect_back(notice: I18n.t('messages.unauthorized_access'))
    end
  end

  def authenticate_admin!
    unless current_user.is_admin?
      redirect_back(notice: I18n.t('messages.unauthorized_access'))
    end
  end

  def authenticate_sponser!
    if current_user && !current_user.is_sponsorer?
      redirect_back(notice: I18n.t('messages.unauthorized_access'))
    end
  end

  def redirect_back(opts = {})
    redirect_to(request.env['HTTP_REFERER'] || root_path, opts)
  end

  def work_in_progress
    redirect_back
    return false
  end

  def current_ability
    user = current_user ? current_user : current_sponsorer
    only_sponsorer = user == current_sponsorer
    @current_ability ||= Ability.new(user, only_sponsorer, current_role)
  end

  def current_role
    current_user.current_role if current_user
  end
end
