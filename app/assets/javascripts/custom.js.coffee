# Flash messages
$(document).ready ->
  setTimeout (->
    $('p.alert').hide 'slow'
  ), 2000
