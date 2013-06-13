require_relative 'player'
require_relative 'die'
require_relative 'game_turn'
require_relative 'treasure_trove'

class Game
	attr_reader :title	

	def initialize(title)
		@title = title
		@players = []
	end

	def add_player(player)
		@players.push(player)
	end

	def total_points
		@players.reduce(0){|sumOfPoints, player| sumOfPoints + player.points}
	end

	def play(rounds)
		puts "there are #{@players.size} players in #{@title}"
		puts @players
		
		treasure = TreasureTrove::TREASURES
		puts "number of treasures = #{treasure.size}"

		treasure.each do |treasure|
			puts "#{treasure.name} (#{treasure.points} Points)"
		end

		1.upto(rounds) do |round|
			if block_given? 
				puts "block was given"
				break if yield
			end
			puts "\nRound Number: #{round}"
			@players.each do |player|
				GameTurn.take_turn(player)
			end
		end
	end

	# def play_round(round)
	# 	puts "\nRound Number: #{round}"
	# 	@players.each do |player|
	# 		GameTurn.take_turn(player)
	# 	end
	# end

	def high_score_entry(player)
		formatted_name = player.name.ljust(20, '.')
		"#{formatted_name}#{player.score}"
	end

	def print_stats
		strong_players, wimpy_players = @players.partition {|player| player.strong?}

		puts "#{@title} High Scores:\n"
		@players.sort.each do |player|
			puts high_score_entry(player)
		end

		puts "#{@title} Statistics:"
		puts "#{strong_players.size} strong players:"
		strong_players.each do |player|
			print_name_and_health(player)
		end

		puts "#{wimpy_players.size} wimpy players:"
		wimpy_players.each do |player|
			print_name_and_health(player)
		end

		@players.each do |player|
			puts "\n#{player.name}'s points totals:"
			player.each_found_treasure do |treasure|
				puts "#{treasure.points} total #{treasure.name} points"
			end
			puts "#{player.points} grand total points"
		end

		puts "#{total_points} total points from treasures found"
	end

	def print_name_and_health(player)
		puts "#{player.name} (#{player.health})"
	end

	def load_players(file)
		File.readlines(file).each do |line|
			add_player(Player.from_csv(line))
			puts line
		end
	end

	def save_high_scores(fileName="high_scores.txt")
		File.open(fileName, "w") do |file|  
			file.write("#{@title} High Score:\n")
			@players.sort.each do |player|
				file.puts high_score_entry(player)
			end
		end
	end
end

if __FILE__ == $0
	player1 = Player.new("johnson")
	player2 = Player.new("moe")
	player3 = Player.new("curly")
	knuckleheads = Game.new("knuckleheads")
	knuckleheads.add_player(player1)
	knuckleheads.add_player(player2)
	knuckleheads.add_player(player3)
	knuckleheads.play(10) do
		knuckleheads.total_points >= 2000
	end
	knuckleheads.print_stats
	knuckleheads.save_high_scores

end