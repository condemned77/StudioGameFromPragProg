require_relative 'player'
require_relative 'game'

player1 = Player.new("johnson")
player2 = Player.new("moe")
player3 = Player.new("curly")


knuckleheads = Game.new("knuckleheads")
knuckleheads.add_Player(player1)
knuckleheads.add_Player(player2)
knuckleheads.add_Player(player3)
knuckleheads.play(7)
