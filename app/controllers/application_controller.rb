# This controller contain the generic methods shared with each other controllers
class ApplicationController < ActionController::Base
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :redirect_to_sign_in, unless: :user_signed_in?

  private

  # Access denied if user isn't member of committee
  def committee_required!
    access_denied unless current_user.committee?
  end

  # denies access, error 401
  def access_denied
    flash[:alert] = 'Accesso negato! Una segnalazione contenente il tentativo di accesso e` stata inviata al comitato.'
    # render status: :unauthorized
    redirect_to root_path
  end

  def redirect_to_sign_in
    redirect_to new_user_session_path
  end

end
