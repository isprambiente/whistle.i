json.messages @messages do |message|
  json.id message.id
  json.created_at l message.created_at
  json.status message.status
  json.set! 'DT_RowId', message.div
  json.set! 'DT_RowClass', message.status
end
