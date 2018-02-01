# Configurazioni
add_button_id = 'add-attachemnt'
attachements_container_id = 'new-message-files'
icon = '<svg class="svg-inline--fa fa-trash-alt fa-w-14" aria-hidden="true" data-prefix="far" data-icon="trash-alt" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M192 188v216c0 6.627-5.373 12-12 12h-24c-6.627 0-12-5.373-12-12V188c0-6.627 5.373-12 12-12h24c6.627 0 12 5.373 12 12zm100-12h-24c-6.627 0-12 5.373-12 12v216c0 6.627 5.373 12 12 12h24c6.627 0 12-5.373 12-12V188c0-6.627-5.373-12-12-12zm132-96c13.255 0 24 10.745 24 24v12c0 6.627-5.373 12-12 12h-20v336c0 26.51-21.49 48-48 48H80c-26.51 0-48-21.49-48-48V128H12c-6.627 0-12-5.373-12-12v-12c0-13.255 10.745-24 24-24h74.411l34.018-56.696A48 48 0 0 1 173.589 0h100.823a48 48 0 0 1 41.16 23.304L349.589 80H424zm-269.611 0h139.223L276.16 50.913A6 6 0 0 0 271.015 48h-94.028a6 6 0 0 0-5.145 2.913L154.389 80zM368 128H80v330a6 6 0 0 0 6 6h276a6 6 0 0 0 6-6V128z"></path></svg>'

# Aggiunge field
add = (container) ->
  rand = Math.floor( Math.random() * (9999999 - 1000000) + 1000000 )
  name = "message[attachments_attributes][#{rand}][file]"
  drop_id = "message_attachments_attributes_#{rand}_file_drop"
  div = document.createElement('div')
  div.id = "message_attachments_attributes_#{rand}_file"
  div.className = "input-group large-6 cell"
  div.innerHTML = "
    <span class='input-group-label'>
      <a id='#{drop_id}' class='alert' title='Rimuovi allegato'>#{icon}</a>
    </span>
    <input class='input-group-field' name='#{name}' type='file'>"
  container.appendChild(div)
  drop = document.getElementById(drop_id)
  drop.addEventListener "click", (e) => 
    e.preventDefault()
    div.remove()

document.addEventListener 'turbolinks:load', (event) ->
  button = document.getElementById(add_button_id)
  container = document.getElementById(attachements_container_id)
  if button != null && container != null
    button.addEventListener "click", (e) => 
      e.preventDefault()
      add(container)
      add(container)
    if container.innerHTML == ""
      add(container)
      add(container)


