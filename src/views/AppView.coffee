class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()

  initialize: ->
    @model.on 'bust', @bust.bind @
    @model.on 'stand', @disableBtns.bind @
    @model.on 'playerWin', @playerWin.bind @
    @model.on 'dealerWin', @dealerWin.bind @
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  disableBtns: ->
    (@$el.find 'button').prop 'disabled', true

  playerWin: ->
    console.log 'playerWin'

  dealerWin: ->
    console.log 'dealerWin'

  bust: ->
    @disableBtns()
    @dealerWin()
