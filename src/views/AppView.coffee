class window.AppView extends Backbone.View
  template: _.template '
    <div id="resultCover" class="coverDiv">
      <div class="winDiv">
        <img class="winImg" src="img/You-win.jpg"/>
        <button class="playAgain"><img src="img/play-again.jpeg"></button>
      </div>
    </div>
    <div id="bettingCover" class="coverDiv">
      <div class="bettingDiv">
        <h1>How much would you like to wager?</h1>
        <h2>Current Balance: <span class="balance"><%= balance %></span></h2>
        <select class="wagerAmount">
          <option value="5">5</option>
          <option value="10">10</option>
          <option value="25">25</option>
        </select>
        <button class="wagerButton">OK</button>
      </div>
    </div>

    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div><h2>Your balance: <span class="balance"><%= balance %></span><h2></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .playAgain': -> @reset()
    'click .wagerButton': -> @wager()

  initialize: ->
    @model.on 'bust', @bust.bind @
    @model.on 'stand', @disableBtns.bind @
    @model.on 'playerWin', @playerWin.bind @
    @model.on 'dealerWin', @dealerWin.bind @
    @render()
    (@$el.find '#bettingCover').show()

  render: ->
    @$el.children().detach()
    @$el.html @template({balance: @model.get 'balance'})
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  disableBtns: ->
    (@$el.find 'hit-button').prop 'disabled', true
    (@$el.find 'stand-button').prop 'disabled', true

  playerWin: ->
    ($ '.winImg').attr 'src', 'img/You-win.jpg'
    (@$el.find '#resultCover').show()
    @model.set 'balance', (@model.get 'balance') + 2 * (@model.get 'wagerAmount')
    @setBalanceVal()

  dealerWin: ->
    ($ '.winImg').attr 'src', 'img/You-lose.jpg'
    (@$el.find '#resultCover').show()

  bust: ->
    @disableBtns()
    @dealerWin()

  reset: ->
    (@$el.find 'button').prop 'disabled', false
    (@$el.find '#resultCover').hide()
    (@$el.find '#bettingCover').show()
    @model.resetHands()

  wager: ->
    @model.set 'wagerAmount',  (@$el.find '.wagerAmount').val()
    @model.set 'balance', (@model.get 'balance') - (@model.get 'wagerAmount')
    @setBalanceVal()
    (@$el.find '#bettingCover').hide()

  setBalanceVal: ->
    (@$el.find '.balance').html (@model.get 'balance')

