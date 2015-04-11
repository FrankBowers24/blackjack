assert = chai.assert

describe "deck constructor", ->

  it "should create a card collection", ->
    collection = new Deck()
    assert.strictEqual collection.length, 520

  it "should have the correct sum of card values", ->
    collection = new Deck()
    total = collection.reduce (memo, card) ->
      memo + card.get 'rank'
    , 0
    assert.strictEqual total, 3120
