class window.CardView extends Backbone.View
  className: 'card'
  tagName: 'img'

  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: ->
    @render()
    # @model.on 'flipped', @render.bind @
    @model.on 'flipped', @flipped.bind @

  render: ->
    @$el.children().detach()
    @$el.html ''
    @$el.attr 'src', "img/cards/#{@model.get 'rankName'}-#{(@model.get 'suitName').toLowerCase()}.png"
    # if not @model.get 'revealed' then @$el.attr 'src', 'img/card-back.png'
    @$el.addClass 'covered' unless @model.get 'revealed'

  flipped: ->
    if @model.get 'revealed' then @$el.removeClass 'covered' else @$el.addClass 'covered'


    # use 'covered' class on card to control src rather than calling render on flip
    #
    #<style>
    # .covered {
    #   content:url("img/card-back.png");
    # }
    # </style>

