class BlogIndex extends Character.IndexView
  title:          'Posts'
  new_item_url:   '#/blog/new'
  new_item_hint:  'Create new post'

  render_item: (model) ->
    id              = model.id
    line1_left      = model.get('title')
    line1_right     = model.draft_or_date()
    line2_left      = ''
    line2_right     = ''
    thumb_image_url = model.thumb_image_url()
    
    img_tag = if thumb_image_url then "<img src='#{ thumb_image_url }' />" else ''

    # refactor this!
    #category_title = ''
    #if blog.options.categories
    #  category = @model.category()
    #  category_title = if category then category.get('title') else 'Not set'

    """ <a href='#/blog/show/#{id}'>
          #{ img_tag }
          <div>
            <strong>#{ line1_left }</strong>
            <aside><small>#{ line1_right }</small></aside>
          </div>
          <div>
            <small><em>#{ line2_left }</em></small>
            <aside>#{ line2_right }</aside>
          </div>
        </a>"""    

  items: ->
    # drafts go first, then published posts
    drafts    = window.blog.posts.filter (p) -> not p.get('published')
    published = window.blog.posts.filter (p) -> p.get('published')

    # then published sorted by date
    reversed  = _(published).sortBy (p) -> p.get('date')
    sorted    = reversed.reverse()

    posts     = drafts.concat(sorted)
    return posts








  scroll_to_active: ->
    if blog.index_scroll_y > 0
      window.scroll(0, blog.index_scroll_y)
    else
      top_offset = $('#index_view a.active').offset().top
      if top_offset - window.scrollY > $(window).height()
        window.scroll(0, top_offset - 100)
  

  set_active: (id) ->
    @unset_active()
    $("#index_view a[href='#/blog/show/#{id}']").addClass('active')
    @scroll_to_active()


  unset_active: ->
    $('#index_view a.active').removeClass('active')


  lock: ->
    blog.index_scroll_y = window.scrollY

    top_bar_height  = $('.top-bar').height()
    app_top_padding = parseInt($('#character').css('padding-top'))

    $(@panel_el).css('top', -window.scrollY + top_bar_height + app_top_padding)
               .addClass('fixed')


  unlock: ->
    $(@panel_el).css('top', '').removeClass('fixed')
    window.scroll(0, blog.index_scroll_y)


  show_preview: (post_id) ->
    @set_active(post_id)

    if @preview then (@preview.remove() ; delete @preview) else @lock()
    
    post      = blog.posts.get(post_id)
    @preview  = new Character.Blog.Views.BlogIndexShow model: post
    
    html = @preview.render().el
    $(@el).append(html)

    window.scroll(0, 0)


  close_preview: ->
    @unlock()

    (@preview.remove() ; delete @preview) if @preview 

    @unset_active()
    blog.index_scroll_y = 0


Character.Blog.Views.BlogIndex = BlogIndex




