assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 518
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 517

  # verify that player hand cards are all revealed
  # verify that only first dealer card is revealed
  # verify that dealer plays when player stands

