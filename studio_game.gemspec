Gem::Specification.new do |s|
	s.name			= "drJohnsons_studio_game_from_pragmatic_studio"
	s.version		= "1.0"
	s.author		= "me, Dr.Jaguar"
	s.email			= "Dr_Jaguar@Johnson.com"
	s.homepage		= "http://www.DrJaguarJohnson.com"
	s.summary		= "jojo"
	s.description	= File.read(File.join(File.dirname(__FILE__), 'README'))

	s.files			= Dir["{bin,lib,spec}/**/*"] + %w(LICENSE README)
	s.test_files	= Dir["spec/**/*"]
	s.executables	= [ 'studio_game' ]

	s.required_ruby_version = '>=1.9'
	s.add_development_dependency 'rspec'
end