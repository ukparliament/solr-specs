

module Odin
	
	class Formatter
	
	  def initialize(config)
		@io = config.out_stream
		
		config.on_event :test_case_started do |event|
      @io.puts "–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––"
      @io.puts "Scenario: #{event.test_case.name}"
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
			
			@io.puts "Scenario #{status}"
			@io.puts "–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––"
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
			else
			  status = event.result.class.to_s
			end
			
			@io.puts "\t#{status}\t#{event.test_step}"
		end
		
	  end
	end
end
