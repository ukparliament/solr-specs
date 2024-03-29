module Odin
	
	class Formatter
	
	  def initialize(config)
		@io = config.out_stream
		
		config.on_event :test_case_started do |event|
      @io.puts "\n"
      @io.puts "[Scenario] #{event.test_case.name}"
    end
		
		config.on_event :test_case_finished do |event|
      
      status = "UNKNOWN"
		  	case event.result.class.to_s
			when "Cucumber::Core::Test::Result::Passed"
			  status = "Passed"
			when "Cucumber::Core::Test::Result::Failed"
			  status = "\e[1mFAILED\e[22m"
			when "Cucumber::Core::Test::Result::Skipped"
			  status = "\e[3mSkipped\e[23m"
			else
			  status = event.result.class.to_s
			end
			
			@io.puts "Scenario #{status} at #{event.test_case.location}"
			@io.puts "\n–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––"
		end
		
		config.on_event :test_step_finished do |event|
			
			status = "UNKNOWN"
		  	case event.result.class.to_s
			when "Cucumber::Core::Test::Result::Passed"
			  status = "Passed"
			when "Cucumber::Core::Test::Result::Failed"
			  status = "\e[1mFAILED\e[22m"
			when "Cucumber::Core::Test::Result::Skipped"
			  status = "\e[3mSkipped\e[23m"
			when "Cucumber::Core::Test::Result::Undefined"
			  status = "(Undefined)"
			else
			  status = event.result.class.to_s
			end
			
			@io.puts "\t#{status}: #{event.test_step}"
		end
		
	  end
	end
end
