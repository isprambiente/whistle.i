class MyCasController < Devise::CasSessionsController
  skip_before_action :redirect_to_sign_in, only: [:new, :single_sign_out]
end
