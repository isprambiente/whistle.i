# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

committee = (status) ->
  switch status
    when true then 'Comitato'
    when false then 'Utente'
    else 'Stato sconosciuto'



$(document).ready ->

  $('table#users').dataTable 
    "deferRender": false
    "pageLength": 50
    "order": [[ 1, "asc" ]]
    responsive: true
    'ajax': {'url': "/users/list.json", 'dataSrc': 'users'}
    'columns': [
      { "data": "id", "sClass": "code"  }
      { "data": "label" }
      { "data": "committee", "sClass": "text-right" }
      { "sClass": "nop", "orderable": false  }
    ]
    "columnDefs": [
      {
        "aTargets": [ 1 ],
        "mRender": ( data, type, full ) -> "<a href='/users/#{full['id']}'>#{full['label']}</a>"
      }
      {
        "aTargets": [ 2 ],
        "mRender": ( data, type, full ) -> committee(full['committee'])      
      }
      {
        "aTargets": [ 3 ],
        "mRender": ( data, type, full ) -> 
          "
           <a href='/users/#{full['id']}' class='button'><i class='fa fa-arrows-alt'></i></a><a href='/users/#{full['id']}' class='button alert' data-method='patch' data-confirm='Attenzione stai per cambiare la qualifica dell`utente! confirmi l`operazione?'><i class='fa fa-cogs'></i></a>
          "
      } 
    ]

  $('table#user_log').dataTable 
    "deferRender": false
    "pageLength": 50
    "order": [[ 0, "desc" ]]
    responsive: true
    'ajax': {'url': "#{window.location.pathname.replace(/\/$/, "")}/log.json", 'dataSrc': 'log'}
    'columns': [
      { "data": "created_at", "sClass": "code" }
      { "data": "message_id", "sClass": "code" }
      { "data": "action"}
    ]
    "columnDefs": [
      {
        "aTargets": [ 1 ],
        "mRender": ( data, type, full ) -> "<a href='/messages/#{full['message_id']}'>#{full['message_id']}</a>"
      }
    ]    