# This controller manage the users rights
# * only the committee can access here
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :committee_required!
  before_action :set_user, except: [:index, :list, :add_key]

  respond_to :html, :json

  # GET /users
  # This page id to manage the users and to set the committee
  def index
  end
  
  # GET /users/list
  # This page send the users json
  def list
    @users = User.all
  end

  # GET /users/1
  # This page show the user information and the user log
  def show
  end

  # GET /users/1/log
  # GET /users/1/log.json
  def log
    Log.create(user: current_user, action: t('log.user_log', author: current_user.label, user: @user.label))
    Log.create(user: @user, action: t('log.user_log', author: current_user.label, user: @user.label))
  end

  
  # POST /users/1/add_key
  # Generate the RSA key
  def add_key
    @user = current_user
    @user.assign_attributes(key_user_params)
    flash[:notice] = 'Chiave aggiunta' if @user.add_key
    @user = current_user
    redirect_to root_path
  end

  # PATCH /users/1/
  # change the user status (standard user / committee)
  def update
    flash[:notice] = "#{@user.label} e` stato aggiornato" if @user.update committee: !@user.committee
    Log.create(user: @user, action: t('log.user_status', author: current_user.label, user: @user.label, status: @user.status))
    Log.create(user: current_user, action: t('log.user_status', author: current_user.label, user: @user.label, status: @user.status))
    redirect_to users_path
  end

  private

  # set the @user variable for all view on exception index, add_key
  def set_user
    @user = User.find(params[:id])
  end

  # set the params needed for RSA key generation
  def key_user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
