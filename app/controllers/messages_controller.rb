# This controller manage the message's model
# * standard user can access only to :new and :create action
# * the committee can access everywhere
class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :committee_required!, except: [:new, :create, :report]
  before_action :set_prerequisite, except: [:index, :list, :new, :create, :report]

  respond_to :html, except: [:index]
  respond_to :html, :json, only: [:index]

  # GET /messages
  # accessible only from committee users
  # this view contain the messages list with the status informations
  def index
    @title = 'Gestione messaggi'
  end

  def report
    @title = 'Stato richieste'
    @messages = Message.all
  end

  # GET /messages/list.json
  def list
    @messages = Message.all
  end

  # GET /messages/1
  # accessible only from committee users
  # This view contain the message information that not require decryption
  def show
    @active = 1
  end

  # POST /message/1/body
  # accessible only from committee users and only if the user have received a message copy
  # This view receive the user key password and decrypt the message body
  def body
    @active = 2
    @destination.password = params[:destination][:password]
    @destination.readed = true unless @destination.readed?
    @destination.readed_at = Time.zone.now unless @destination.readed_at.present?
    @destination.save
    @message.update status: :message_active if @message.status == 'message_new'
    render action: :show
  end

  # POST /message/1/detail
  # accessible only from committee users and only if the user have received a message copy
  # This view receive the user key password and decrypt the sender details
  def detail
    WhistleMailer.detail_message(current_user, @message).deliver_later
    @active = 3
    @destination.password = params[:destination][:password]
    @destination.note = params[:destination][:note]
    @destination.detailed = true
    @destination.detailed_at = Time.zone.now unless @destination.detailed_at.present?
    @destination.save
    @message.update status: :message_active if @message.status == 'message_new'
    render action: :show
  end

  # POST /message/1/attachment/1
  # accessible only from committee users and only if the user have received a message copy
  # This view receive the user key password and decrypt a message's attachment
  def attachment
    @attachment = @destination.attachments.find(params[:attachment_id])
    send_data @attachment.file_streaming(params[:attachment][:password]),
      filename: @attachment.file_file_name,
      type: @attachment.file_content_type
  end

  # GET /messages/new
  # accessible from any authenticated users
  # this is the root path
  # This view contain the form for create a new message
  def new
    @title = 'Nuova segnalazione'
    @message = Message.new
  end

  # POST /messages
  # accessible from any authenticater users
  # this view create a new message
  def create
    @title = 'Nuova segnalazione'
    @message = Message.new(message_params)
    @message.detail = [current_user.label, current_user.email, current_user.username, Time.zone.now].join(';')
    if @message.save
      WhistleMailer.new_message.deliver_later
      #redirect_to root_path, notice: I18n.t('flash.message.create.notice')
    else
      render action: :new, alert: I18n.t('flash.message.create.alert')
    end
  end

  # PATCH/PUT /messages/1
  # accessible only from committee users
  # this view change the status of a message
  def update
    @active = 1
    @message.update(status: :message_closed) if @message.status == 'message_active'
    render action: :show
  end

  private

  # set the common var: @title, @message, @destination
  def set_prerequisite
    @title = 'Gestione messaggi'
    @message = Message.find(params[:id])
    @destination = @message.destinations.find_by user: current_user
    Log.create(user: current_user, message: @message, action: t(action_name, scope: 'log.message', status: @message.status))
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit(:body, attachments_attributes: [:file])
  end
end
