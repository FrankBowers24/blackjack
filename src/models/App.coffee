# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    (@get 'playerHand').on 'bust', @playerBust.bind @
    (@get 'playerHand').on 'stand', @playerStand.bind @
    (@get 'dealerHand').on 'gameOver', @gameResult.bind @
    @.set 'balance', 1000

  playerBust: ->
    @trigger('bust')

  playerStand: ->
    @trigger('stand')
    (@get 'dealerHand').play()

  gameResult: ->
    playerScore = (@get 'playerHand').displayScore()
    dealerScore = (@get 'dealerHand').displayScore()
    if (dealerScore > 21)
      @trigger 'playerWin'
    else if (playerScore > dealerScore)
      @trigger 'playerWin'
    else
      @trigger 'dealerWin'

  resetHands: ->
    (@get 'playerHand').resetHand()
    (@get 'dealerHand').resetDealer()

