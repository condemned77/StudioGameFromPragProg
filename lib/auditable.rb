module StudioGame_MJ
	module Auditable
		def audit
			puts "Rolled a #{self.number}(#{self.class})"
		end
	end
end