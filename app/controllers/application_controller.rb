class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  # Access denied if user isn't member of committee
  def committee_required!
    access_denied unless current_user.committee?
  end

  def access_denied
    flash[:alert] = 'Accesso negato! Una segnalazione contenente il tentativo di accesso e` stata inviata al comitato.'
    # render status: :unauthorized
    redirect_to root_path
  end

  def redirect_to_sign_in
    redirect_to new_user_session_path
  end
end
