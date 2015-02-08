module View
extend self
	def boot_up_message(file)
		puts "Hi! Type \"help\" to see available commands"
		puts "Working with: #{file}"
	end

	def error(message=nil)
		case message
		when nil
			puts "Error - Are you trying to crash me?"
		when "empty"
			puts "Error - List is empty."
		when "outstanding"
			puts "Error - No outstanding tasks."
		when "completed"
			puts "Error - No completed tasks."
		end
	end

	def help
		puts "These are the available options:
			- read
			- add
			- delete
			- check"
	end

	def completed(content)
		puts "COMPLETED TASKS:"
		print (content)
	end

	def outstanding(content)
		puts "OUTSTANDING TASKS:"
		print (content)
	end
	def print(content)
		puts content
	end

	def done
		puts "Done!"
	end

	def no_command
		puts "I got no command or I don't know how to handle it"
	end
end

