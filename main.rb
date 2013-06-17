require_relative 'player'
require_relative 'game'
require_relative 'clumsy_player'
require_relative 'berserk_player'

knuckleheads = Game.new("knuckleheads")
puts ARGV
knuckleheads.load_players(ARGV.shift || "players.csv")

player4 = ClumsyPlayer.new("Klutz", 7)
knuckleheads.add_player(player4);

player5 = BerserkPlayer.new("berserki")
knuckleheads.add_player(player5)

loop do
	puts "\nHow many game rounds? ('quit' to exit)"
	input = gets.chomp.downcase

	case input
		when /^\d+$/
			knuckleheads.play(Integer(input))
		when 'quit', 'exit'
			break
		else
			puts "Please enter a number or 'quit'"
	end
end

knuckleheads.save_high_scores
puts "high score saved"

# if __FILE__ == $0
# 	player1 = Player.new("johnson")
# 	player2 = Player.new("moe")
# 	player3 = Player.new("curly")
# 	player4 = ClumsyPlayer.new("Klutz", 7)


# 	knuckleheads = Game.new("knuckleheads")
# 	knuckleheads.add_player(player1)
# 	knuckleheads.add_player(player2)
# 	knuckleheads.add_player(player3)
# 	knuckleheads.add_player(player4)
# 	knuckleheads.play(7)
# end