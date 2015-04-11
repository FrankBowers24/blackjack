
# Verify that initial balance is 1000
# is betting cover visible?
# does balance decline by wager?
# does results cover appear after game completes?
# does better cover appear after 'play again'?
# does balance increase by  2 * wager if player wins?
assert = chai.assert

describe "initial state", ->

  appView = new AppView(model: new App()).$el.appendTo 'body'

  it "betting cover should be visible", ->
