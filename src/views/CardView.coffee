class window.CardView extends Backbone.View
  className: 'card'
  tagName: 'img'

  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: ->
    @render()
    @model.on 'flipped', @render.bind @

  render: ->
    @$el.children().detach()
    @$el.html ''
    @$el.attr 'src', "img/cards/#{@model.get 'rankName'}-#{(@model.get 'suitName').toLowerCase()}.png"
    if not @model.get 'revealed' then @$el.attr 'src', 'img/card-back.png'
    @$el.addClass 'covered' unless @model.get 'revealed'

