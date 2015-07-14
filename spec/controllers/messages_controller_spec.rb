require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  include Devise::TestHelpers

  before(:each) do
    @user = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:admin)
    @message = FactoryGirl.create(:message)
  end

  def user_in!
    sign_in :user, @user
  end

  def admin_in!
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
      expect(assigns(:messages)).to eq(nil)
    end

    it 'GET #new' do
      get :new
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/auth/sign_in')
      expect(assigns(:message)).to eq(nil)
    end

    it 'POST #create' do
      post :create, message: FactoryGirl.attributes_for(:message)
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/auth/sign_in')
      expect(assigns(:message)).to eq(nil)
    end

    it 'GET #show' do
      get :show, id: @message.id
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/auth/sign_in')
      expect(assigns(:message)).to eq(nil)
    end

    it 'POST #body' do
      post :body, id: @message.id
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/auth/sign_in')
      expect(assigns(:message)).to eq(nil)
    end

    it 'POST #detail' do
      post :detail, id: @message.id
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/auth/sign_in')
      expect(assigns(:message)).to eq(nil)
    end

    it 'POST #attachment' do
      post :attachment, id: @message.id, attachment_id: @message.destinations.first.attachments.first.id
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/auth/sign_in')
      expect(assigns(:message)).to eq(nil)      
    end

    it 'POST #update' do
      post :update, id: @message.id
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/auth/sign_in')
      expect(assigns(:message)).to eq(nil)      
    end
  end

  context 'when user logged in' do
    before(:each) do
      sign_in :user, @user
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
      expect(assigns(:messages)).to eq(nil)
    end

    it 'GET #new' do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
      expect(assigns(:message)).to be_a_new(Message)
    end

    it 'POST #create' do
      FactoryGirl.create(:admin)
      post :create, message: FactoryGirl.attributes_for(:message)
      ari = [@user.label, @user.email, @user.username, assigns(:message).detail.last]
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/')
      expect(assigns(:message).persisted?).to eq(true)
      expect(assigns(:message).detail).to eq(ari)
      expect(assigns(:message).destinations.count).to eq(2)
      dest_ids = assigns(:message).destinations.pluck(:id)
      expect(Attachment.where(destination_id: dest_ids).count).to eq(2)
    end

    it 'GET #show' do
      get :show, id: @message.id
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/')
      expect(assigns(:message)).to eq(nil)
    end

    it 'POST #body' do
      post :body, id: @message.id
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/')
      expect(assigns(:message)).to eq(nil)
    end

    it 'POST #detail' do
      post :detail, id: @message.id
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/')
      expect(assigns(:message)).to eq(nil)
    end

    it 'POST #attachment' do
      @message = FactoryGirl.create(:message)
      post :attachment, id: @message.id, attachment_id: @message.destinations.first.attachments.first.id
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/')
      expect(assigns(:message)).to eq(nil)      
    end

    it 'POST #update' do
      post :update, id: @message.id
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/')
      expect(assigns(:message)).to eq(nil)      
    end
  end

  context 'when admin logged in' do
    before(:each) do
      sign_in :user, @admin
    end

    it 'GET #index' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end

    it 'GET #list' do
      get :list, format: :json
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:list)
      expect(assigns(:messages)).to eq(Message.all)
    end

    it 'GET #new' do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
      expect(assigns(:message)).to be_a_new(Message)
    end

    it 'POST #create' do
      FactoryGirl.create(:admin)
      post :create, message: FactoryGirl.attributes_for(:message)
      ari = [@admin.label, @admin.email, @admin.username, assigns(:message).detail.last]
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/')
      expect(assigns(:message).persisted?).to eq(true)
      expect(assigns(:message).detail).to eq(ari)
      expect(assigns(:message).destinations.count).to eq(2)
      dest_ids = assigns(:message).destinations.pluck(:id)
      expect(Attachment.where(destination_id: dest_ids).count).to eq(2)
    end

    it 'GET #show' do
      get :show, id: @message.id
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
      expect(assigns(:message)).to eq(@message)
    end

    it 'POST #body' do
      get :post, id: @message.id
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
      expect(assigns(:message)).to eq(@message)      
    end

    it 'POST #detail' do
    end

    it 'POST #attachment' do
    end

    it 'POST #update' do
    end
  end
end
