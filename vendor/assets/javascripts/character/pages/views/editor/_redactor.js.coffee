class Redactor extends Character.Pages.Views.Base
  tagName:    'div'
  className:  'mode redactor'

  initialize: ->
    html = @render().el
    $('.editor header').after(html)

    @html = document.getElementById('html')
    
    $(@html).redactor
      #autoresize: false
      #air: true

    @resize_panels()


  render: ->
    post  = if @model then @model.toJSON() else { html: ''}
    state = if @model then @model.state()  else 'New'

    html = """<div class='chr-panel center fixed'>
                <section class='container'>
                  <header>
                    <span class='title'>#{state}</span>
                  </header>
                  <div>
                    <textarea id='html'>#{post.html}</textarea>
                  </div>
                </section>
              </div>"""

    $(this.el).html html
    return this


  resize_panels: ->
    
    window_height   = $(window).height()
    toolbar_height  = $('.redactor_toolbar').outerHeight()
    footer_height   = $('footer').outerHeight()
    
    $('.redactor_editor').css 'height', window_height - $('.redactor_box').offset().top - footer_height - 22
    $('#html').css            'height', window_height - $('.redactor_box').offset().top - footer_height - 32
    
    $(window).smartresize =>
      @resize_panels()


  destroy: ->
    # remove redactor


  get_html: ->
    @html.value


Character.Pages.Views.Editor.Redactor = Redactor


