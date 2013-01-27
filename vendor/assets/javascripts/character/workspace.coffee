class CharacterWorkspace
  constructor: ->
    @current_view = null
    @router       = new Backbone.Router()
  
  current_view_is: (class_name) ->
    (@current_view and @current_view.constructor.name == class_name)

  set_current_view: (view_function) ->
    (@current_view.remove() ; delete @current_view) if @current_view
    @current_view = view_function()


window.Character = CharacterWorkspace