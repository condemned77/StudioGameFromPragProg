require_relative 'game'
require_relative 'player'

describe Game do 

	before do
		@game = Game.new("Knuckleheads")
		@initialHealth = 100
		@player = Player.new("moe", @initialHealth)
		@game.add_player(@player)
	end

	it "has a capitalized Name" do
		@player.name.should == "Moe"
	end

	it "roles a high number" do
		Die.any_instance.stub(:roll).and_return(5)

		@game.play(2)
		@player.health.should == @initialHealth + (15*2) 

	end
	
	it "roles a medium number" do
		Die.any_instance.stub(:roll).and_return(4)
		
		@game.play(2)
		@player.health.should == @initialHealth
	end	


	it "roles a low number" do
		Die.any_instance.stub(:roll).and_return(2)
		numOfRounds = 7

		@game.play(numOfRounds)
		@player.health.should == @initialHealth - (10*numOfRounds)
	end

	it "assigns a treasure for points during a player's turn" do
		game = Game.new("Knuckleheads")
		player = Player.new("moe")
		game.add_player(player)

		game.play(1)
		player.points.should_not be_zero
	end

	it "computes total points as the sum of all player points" do
	  game = Game.new("Knuckleheads")
	  
	  player1 = Player.new("moe")
	  player2 = Player.new("larry")
	  
	  game.add_player(player1)
	  game.add_player(player2)
	  
	  player1.found_treasure(Treasure.new(:hammer, 50))
	  player1.found_treasure(Treasure.new(:hammer, 50))
	  player2.found_treasure(Treasure.new(:crowbar, 400))
	  
	  game.total_points.should == 500
	end


	context "in a collection of players" do
		before do
			@player1 = Player.new("moe", 100)
			@player2 = Player.new("larry", 200)
			@player3 = Player.new("curly", 300)

			@players = [@player1, @player2, @player3]
		end

		it "is sorted by decreasing score" do
			@players.sort.should == [@player3, @player2, @player1]
		end
	end
end