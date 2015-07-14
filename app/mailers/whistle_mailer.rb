class WhistleMailer < ApplicationMailer
  def new_message
    mail to: User.committee.map{|u| u.email}, subject: 'Whistle - Nuova segnalazione inviata su Whistle.I'
  end

  def detail_message(user, message)
    @user = user
    @message = message
    mail to: User.committee.map{|u| u.email}, subject: 'Whistle - Accesso ai dettagli di un messaggio'
  end
end
