require_relative 'auditable'

module StudioGame_MJ

	class Die
		include Auditable
		attr_reader :number
		
		def initialize
			self.roll		
		end


		def roll
			@number = rand(1..6)
			audit
			@number
		end

	end


	if __FILE__ == $0
		puts Die.new()
	end
end