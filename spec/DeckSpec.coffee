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

  describe 'deal player', ->
    it 'should give the player two cards both face up', ->
      assert.strictEqual hand.length, 2
      assert.strictEqual ((hand.at 0).get 'revealed'), true
      assert.strictEqual ((hand.at 1).get 'revealed'), true

  describe 'deal dealer', ->
    it 'should give the dealer two cards, the first face down and the second face up', ->
      dealerHand = deck.dealDealer()
      assert.strictEqual dealerHand.length, 2
      assert.strictEqual ((dealerHand.at 0).get 'revealed'), false
      assert.strictEqual ((dealerHand.at 1).get 'revealed'), true



  # verify that player hand cards are all revealed
  # verify that only first dealer card is revealed
  # verify that dealer plays when player stands

