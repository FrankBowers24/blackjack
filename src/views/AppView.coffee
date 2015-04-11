class window.AppView extends Backbone.View
  template: _.template '
    <div class="coverDiv">
      <div class="winDiv">
        <img class="winImg" src="img/You-win.jpg"/>
        <button class="playAgain"><img src="img/play-again.jpeg"></button>
      </div>
    </div>

    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .playAgain': -> @reset()

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
    (@$el.find 'hit-button').prop 'disabled', true
    (@$el.find 'stand-button').prop 'disabled', true

  playerWin: ->
    (@$el.find '.coverDiv').show()

  dealerWin: ->
    (@$el.find '.coverDiv').show()

  bust: ->
    @disableBtns()
    @dealerWin()

  reset: ->
    (@$el.find 'button').prop 'disabled', false
    (@$el.find '.coverDiv').hide()
    @model.resetHands()

