require_relative 'treasure_trove'
require_relative 'playable'

module StudioGame_MJ

	class Player
		include Playable

		attr_accessor :health
		attr_accessor :name

		def initialize(name, health = 100)
			@name = name.capitalize
			@health = health
			@found_treasures = Hash.new(0)
		end

		def self.from_csv(line)
			playerName, playerHealth = line.split(',')
			Player.new(playerName, Integer(playerHealth))
		end

		def found_treasure(treasure)
			@found_treasures[treasure.name] += treasure.points

			puts "#{@name} found a #{treasure.name} worth #{treasure.points} points"
			puts "#{@name}'s treasures: #{@found_treasures}" 
		end

		def score
			@health + points
		end

		def to_s
			"Hi I'm #{@name} with health = #{@health}, points = #{points}, and score = #{score}"
		end

		def <=>(other)
			other.score <=> score
		end

		def points
			@found_treasures.values.reduce(0, :+)
		end

		def each_found_treasure
			@found_treasures.each do |name, points|
				yield (Treasure.new(name, points))
			end
		end
	end

	if __FILE__ == $0
		player1 = Player.new("johnson", 150)
		player2 = Player.new("moe")
		player3 = Player.new("curly")

		player1.found_treasure(Treasure.new(:hammer, 50))
	 	player1.found_treasure(Treasure.new(:hammer, 50))

	 	puts player1.to_s
		puts player1.strong?
	end
end