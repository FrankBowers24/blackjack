assert = chai.assert

describe "deck constructor", ->

  it "should create a card collection", ->
    collection = new Deck()
    assert.strictEqual collection.length, 520

  it "should have 10 instances of each card", ->
    collection = new Deck()
    collection.sort( (a, b) ->
      console.log a, b
      )
