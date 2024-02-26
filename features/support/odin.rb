module Odin
	class Formatter
	  def initialize(config)
		@io = config.out_stream
		config.on_event :test_case_started do |event|
		  print_test_case_name(event.test_case)
		end
	  end
	
	  def print_test_case_name(test_case)
	    @io.puts "  #{test_case.name.upcase}"

            
	  end
	end
end
