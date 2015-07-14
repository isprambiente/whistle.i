
$(document).ready ->
  tinyMCE.init
    selector: 'textarea.tinymce'
    theme: 'modern'
    height: 150
    relative_urls: false
    remove_script_host: false
    document_base_url: 'http://ls-osa.uniroma3.it/'
    theme_advanced_toolbar_location: 'top'
    theme_advanced_toolbar_align: 'left'
    theme_advanced_buttons3_add: [ 'tablecontrols' ]
    plugins: 'table,advlist,autolink,link,image,lists,charmap,print,preview,hr,anchor,pagebreak,searchreplace,visualblocks,visualchars,code,fullscreen,insertdatetime,media,nonbreaking,save,table,directionality,emoticons,paste,textcolor,image'
    statusbar: false
    menubar: false
    toolbar: 'undo redo | styleselect | bold italic | bullist numlist outdent indent | link'
    lang: 'it'
    browser_spellcheck: true
    language: 'it'

    $(document).foundation()
    Turbolinks.enableTransitionCache()
    Turbolinks.enableProgressBar()
  $('#userModal').foundation('reveal','open');