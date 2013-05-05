require_relative 'treasure_trove'

class Player
	attr_reader :health
	attr_accessor :name

	def initialize(name, health = 100)
		@name = name.capitalize
		@health = health
		@found_treasures = Hash.new(0)
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

	def blam
		puts "#{@name} got blamed!"
		@health -= 10
	end

	def w00t
		puts "#{@name} got w00ted!"
		@health += 15
	end

	def strong?
		@health > 100
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