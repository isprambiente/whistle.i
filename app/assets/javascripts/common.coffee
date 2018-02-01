document.addEventListener 'turbolinks:load', (event) ->
  foundation = $(document).foundation()
  FontAwesome.dom.i2svg()

  if document.getElementById('add_key') != null
    $('#add_key').foundation('open')

document.addEventListener 'turbolinks:before-cache', (event) ->
  FontAwesome.dom.i2svg()

