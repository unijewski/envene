(($, window, document, undefined_) ->
  Plugin = (element, options) ->
    @element = element
    @settings = $.extend({}, defaults, options)
    @_defaults = defaults
    @_name = pluginName
    @init()
  pluginName = 'metisMenu'
  defaults = toggle: true
  Plugin:: = init: ->
    $this = $(@element)
    $toggle = @settings.toggle
    $this.find('li.active').has('ul').children('ul').addClass 'collapse in'
    $this.find('li').not('.active').has('ul').children('ul').addClass 'collapse'
    $this.find('li').has('ul').children('a').on 'click', (e) ->
      e.preventDefault()
      $(this).parent('li').toggleClass('active').children('ul').collapse 'toggle'
      $(this).parent('li').siblings().removeClass('active').children('ul.in').collapse 'hide' if $toggle

  $.fn[pluginName] = (options) ->
    @each ->
      $.data this, 'plugin_' + pluginName, new Plugin(this, options) unless $.data(this, 'plugin_' + pluginName)

) jQuery, window, document
