class ApplicationController < ActionController::Base
  include Pundit

  before_action :redirect_if_not_signed_in
  before_action :set_current_user

  protected

  def current_user
    if cookies.signed[:user_id].present?
      User.find_by id: cookies.signed[:user_id]
    end
  end

  def set_current_user
    @current_user = current_user
  end

  def redirect_if_not_signed_in
    if current_user.blank?
      return if params[:controller] == 'users' && params[:action] == 'new'
      return if params[:controller] == 'pages'

      redirect_to new_user_url
    end
  end
end
