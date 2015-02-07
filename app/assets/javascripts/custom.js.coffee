# Flash messages
$(document).ready ->
  setTimeout (->
    $('p.alert').hide 'slow'
  ), 2000

# Active elements in the navigation
$(document).ready ->
  commonElem = $('a[href="' + @location.pathname + '"]')
  nestedElem = commonElem.parent('li').parent('ul').siblings('a')
  if nestedElem.length
    nestedElem.addClass 'active-menu'
  else
    commonElem.addClass 'active-menu'
