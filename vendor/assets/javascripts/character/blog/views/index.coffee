class BlogIndex extends Character.IndexView
  options:
    title:        'Posts'
    scope:        'blog'
    reorderable:  false
    model_slug:   'Character-Post'


    render_item_options:
      action_name:  'show'
      image_url:    'thumb_image_url'
      line1_left:   'title'
      line1_right:  'date_or_state'
      line2_left:   'excerpt'


    items: ->
      # drafts go first, then featured and published posts
      drafts    = window.blog.posts.filter (p) -> not p.get('published')
      featured  = window.blog.posts.filter (p) -> p.get('published') and p.get('featured')
      published = window.blog.posts.filter (p) -> p.get('published') and not p.get('featured')

      # then featured sorted by date
      featured_reversed  = _.sortBy featured, (p) -> p.get('date')
      featured_sorted    = featured_reversed.reverse()

      # then published sorted by date
      published_reversed  = _.sortBy published, (p) -> p.get('date')
      published_sorted    = published_reversed.reverse()

      posts = _.union(drafts, featured_sorted, published_sorted)
      return posts


  show_preview: (post_id) ->
    @set_active(post_id)

    if @preview then (@preview.remove() ; delete @preview) else @lock_scroll()
    
    post      = blog.posts.get(post_id)
    @preview  = new Character.Blog.Views.BlogIndexShow model: post
    
    html = @preview.render().el
    $(@el).append(html)

    @scroll_top()


  close_preview: ->
    @unlock_scroll()

    (@preview.remove() ; delete @preview) if @preview 

    @unset_active()
    @flush_scroll_y()


Character.Blog.Views.BlogIndex = BlogIndex





