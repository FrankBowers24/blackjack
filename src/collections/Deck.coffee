class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @add _([0...520]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card % 10 / 13)

  dealPlayer: -> new Hand [@pop(), @pop()], @

  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true

  last: ->
    card = @at @length-1
    card

