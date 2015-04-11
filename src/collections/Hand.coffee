class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    card = @deck.pop()
    @add card
    if @displayScore() > 21 then @trigger 'bust'
    card

  stand: ->
    @trigger 'stand'

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  displayScore: ->
    scrs = @scores()
    if (scrs[1] < 22) then scrs[1] else scrs[0]

  play: ->
    setTimeout (@autoDraw.bind @), 1000
    (@at 0).flip()


  autoDraw: ->
    console.log 'AutoDraw'
    if @displayScore() < 17
      @add @deck.pop()
      setTimeout (@autoDraw.bind @), 1000
    else
      @trigger 'gameOver'


