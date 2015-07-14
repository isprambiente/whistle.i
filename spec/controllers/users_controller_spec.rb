require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include Devise::TestHelpers

  def user_in!
    @user = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:admin)
    sign_in :user, @user
  end

  def admin_in!
    @user = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:admin)
    sign_in :user, @admin
  end

  context 'when not logged in' do
    it 'GET #index' do
      get :index
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/auth/sign_in')
    end

    it 'GET #list' do
      get :list, format: :json
      expect(response).to have_http_status(:unauthorized)
      expect(assigns(:users)).to eq(nil)
    end

    it 'GET #show' do
      get :show, id: 1
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('http://test.host/auth/sign_in')
      expect(assigns(:user)).to eq(nil)
    end

    it 'GET #log' do
      get :log, format: :json, id: 1
      expect(response).to have_http_status(:unauthorized)
      expect(assigns(:user)).to eq(nil)
    end

    it 'PATCH #update' do
      patch :update, id: 1
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('http://test.host/auth/sign_in')
      expect(assigns(:user)).to eq(nil)
    end
    
    it 'POST #add_key' do
      post :add_key
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('http://test.host/auth/sign_in')
      expect(assigns(:user)).to eq(nil)
    end
  end

  context 'when user logged in' do
    before(:each) do
      user_in!
    end

    it 'GET #index' do
      get :index
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/')
    end

    it 'GET #list' do
      get :list, format: :json
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/')
      expect(assigns(:users)).to eq(nil)
    end

    it 'GET #show' do
      get :show, id: @user.id
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/')
      expect(assigns(:user)).to eq(nil)
    end

    it 'GET #log' do
      get :log, format: :json, id: @user.id
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/')
      expect(assigns(:user)).to eq(nil)
    end

    it 'PATCH #update' do
      patch :update, id: @user.id
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/')
      expect(assigns(:user)).to eq(nil)
    end
    
    it 'POST #add_key' do
      post :add_key
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/')
      expect(assigns(:user)).to eq(nil)
    end
  end

  context 'when admin logged in' do
    it 'GET #index' do
      admin_in!
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end

    it 'GET #list as json' do
      admin_in!
      get :list, format: :json
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:list)
      expect(assigns(:users)).to eq(User.all)
    end

    it 'GET #show' do
      admin_in!
      get :show, id: @admin.id
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
      expect(assigns(:user)).to eq(@admin)
    end

    it 'GET #log' do
      admin_in!
      get :log, format: :json, id: @user.id
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:log)
      expect(assigns(:user)).to eq(@user)
      expect(@user.logs.count).to eq(1)
      expect(@admin.logs.count).to eq(1)
    end

    it 'PATCH #update to admin' do
      admin_in!
      patch :update, id: @user.id
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/users')
      expect(assigns(:user)).to eq(@user)
      expect(assigns(:user).committee?).to eq(true)
    end

    it 'PATCH #update to user' do
      admin_in!
      @admin2 = FactoryGirl.create(:admin_init)
      patch :update, id: @admin2.id
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/users')
      expect(assigns(:user)).to eq(@admin2)
      expect(assigns(:user).committee?).to eq(false)
    end

    it 'POST #add_key' do
      @admin = FactoryGirl.create(:admin_init)
      sign_in :user, @admin
      post :add_key, user: {password: '12345678'}
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
      expect(assigns(:user)).to eq(@admin)
    end

    it 'POST #add_key if admin have a key' do
      @admin = FactoryGirl.create(:admin)
      sign_in :user, @admin
      get :add_key, user: {password: '12345678'}
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
      expect(assigns(:user)).to eq(@admin)
      expect(assigns(:user).valid?).to eq(false)
    end
  end
end
