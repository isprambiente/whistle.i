add_attachment = ->
  id =  Math.floor((Math.random() * 10000) + 1)
  "<div class='large-4 medium-6 columns'><input class='file required' name='message[attachments_attributes][#{id}][file]' id='message_attachments_attributes_#{id}_file' type='file'></div>"

status = (id) ->
  switch id
    when "message_new" then 'Pendente'
    when "message_active" then 'In lavorazione'
    when "message_closed" then 'Chiusa'
    else 'Stato sconosciuto'


$(document).ready ->
  $('#add-attachemnt').click ->
    $('#attachments').append(add_attachment)
  if $('#attachments').is(':empty')
    $('#attachments').append(add_attachment)

  $('table#messages').dataTable 
    "deferRender": true
    "pageLength": 50
    "order": [[ 0, "desc" ]]
    responsive: true
    'ajax': {'url': "/messages/list.json", 'dataSrc': 'messages'}
    'columns': [
      { "data": "id", "sClass": "code" }
      { "data": "created_at" }
      { "data": "status", "sClass": "text-right" }
      { "sClass": "nop", "orderable": false  }
    ]
    "columnDefs": [
      {
        "aTargets": [ 1 ],
        "mRender": ( data, type, full ) -> "<a href='/messages/#{full['id']}'>#{full['created_at']}</a>"
      }
      {
        "aTargets": [ 2 ],
        "mRender": ( data, type, full ) -> status(full['status'])      
      }
      {
        "aTargets": [ 3 ],
        "mRender": ( data, type, full ) -> 
          "<a href='/messages/#{full['id']}' class='button'><i class='fa fa-arrows-alt'></i></a>"
      } 

    ]