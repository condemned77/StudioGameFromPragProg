module StudioGame_MJ

	module Playable
		def blam
			puts "#{self.name} got blamed!"
			self.health -= 10
		end

		def w00t
			puts "#{self.name} got w00ted!"
			self.health += 15
		end

		def strong?
			self.health > 100
		end
		
		
	end
end