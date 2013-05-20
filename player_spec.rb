require_relative 'player'
require_relative 'treasure_trove'

describe Player do 

	before do
		@initialHealth = 150
		@player = Player.new("jason", @initialHealth)
		#Running an rspec file creates the standard output which the program during the usual execution
		#created. We need a way to switch this off.
		#$stdout provides access to the standard output. We overide the standard output to the console
		#by assigning a different object to $stdout. 
		$stdout = StringIO.new
	end

	it "has a capitalized Name" do
		
		@player.name.should == "Jason"

	end
	
	it "can be created from a CSV string" do
	  player = Player.from_csv("larry,150")

	  player.name.should == "Larry"
	  player.health.should == 150
	end

	
	it "has initial health" do
		@player.health.should == @initialHealth
	end
	
	it "has points of 100 after finding to treasures worth 50" do
		@player.found_treasure(Treasure.new(:hammer, 50))
 		@player.found_treasure(Treasure.new(:hammer, 50))

 		@player.points.should == 100
	end

	it "has a string representation" do
		@player.found_treasure(Treasure.new(:hammer, 50))
 		@player.found_treasure(Treasure.new(:hammer, 50))
 		
		@player.to_s.should == "Hi I'm Jason with health = #{@initialHealth}, points = 100, and score = 250"
	end

	it "computes a score as the sum of its health and length of name" do
 		@player.found_treasure(Treasure.new(:hammer, 50))
 		@player.found_treasure(Treasure.new(:hammer, 50))

 		@player.score.should == 250
	end

	it "increases health by 15 when w00ted" do
		@player.w00t.should == @initialHealth + 15
	end

	it "decreases health by 10 when blammed" do
		@player.blam.should == @initialHealth - 10
	end

	it "computes points as the sum of all treasure points" do
	  @player.points.should == 0

	  @player.found_treasure(Treasure.new(:hammer, 50))

	  @player.points.should == 50

	  @player.found_treasure(Treasure.new(:crowbar, 400))
	  
	  @player.points.should == 450
	  
	  @player.found_treasure(Treasure.new(:hammer, 50))

	  @player.points.should == 500
	end

	it "yields each found treasure and its total points" do
  @player.found_treasure(Treasure.new(:skillet, 100))
  @player.found_treasure(Treasure.new(:skillet, 100))
  @player.found_treasure(Treasure.new(:hammer, 50))
  @player.found_treasure(Treasure.new(:bottle, 5))
  @player.found_treasure(Treasure.new(:bottle, 5))
  @player.found_treasure(Treasure.new(:bottle, 5))
  @player.found_treasure(Treasure.new(:bottle, 5))
  @player.found_treasure(Treasure.new(:bottle, 5))
  
  yielded = []
  @player.each_found_treasure do |treasure|
    yielded << treasure
  end
  
  yielded.should == [
    Treasure.new(:skillet, 200), 
    Treasure.new(:hammer, 50), 
    Treasure.new(:bottle, 25)
 ]
end

	context "for strong players" do
		before do
			@initialHealth = 150;
			@player = Player.new("freddy", @initialHealth)
		end


		it "is strong" do
			@player.should be_strong
		end
	end

	context do
		before do 
			@initialHealth = 100
			@player = Player.new("wimpy", @initialHealth)

		end

		it "for wimpy player" do
			@player.should_not be_strong
		end

	end
end