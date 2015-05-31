$ ->
  $('textarea.wmd-input').each (i, input) ->
    attr = $(input).attr('id').split('wmd-input')[1]
    converter = new Markdown.Converter()
    Markdown.Extra.init(converter)
    help =
      handler: () ->
        window.open('http://daringfireball.net/projects/markdown/syntax')
        false
      title: 'Markdown Editing Help'
    editor = new Markdown.Editor(converter, attr, help)
    editor.run()

$ ->
  $('.wmd-output').each (i) ->
    converter = new (Markdown.Converter)
    content = $(@).html()
    $(@).html converter.makeHtml(content)
