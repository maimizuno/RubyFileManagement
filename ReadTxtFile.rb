# ----------------------------------------------------------------------------------------------------
# Author: Mai Mizuno
# Description:
# The script is designed to display the content of a specified file and identifies
# the occurrence of "Ruby" in the content after verifying the existence of the file.
# ----------------------------------------------------------------------------------------------------

# Assign variables
input_file = "Story1511679.txt"  # file name
ruby_occurrence = 0 # occurrence of the "Ruby" - initialise it with 0
phrase = "Ruby" # phrase to search within the content

# Check if the file exists.
if File.exist?(input_file)

  # If the file exists, display a confirmation message
  puts "The file #{input_file} found.\n"

  # If the file exists, read it line by line and store each line in an array
  input_array = File.readlines(input_file)

  # Check if any elements in the array contains the phrase
  if input_array.any? { |content|content =~ /#{phrase}/}

    # If it does, display a confirmation message
    puts "It contains the phrase \"#{phrase}\".\n\n"

    # Display the content
    puts "Content: "
    puts "----------------------------------------------------------------"
    input_array.each do |line| # Iterate over each line
      puts line # Print each line
      ruby_occurrence += 1 if line =~ /#{phrase}/  # Search for the phrase in the line
    end
    puts "----------------------------------------------------------------\n"

    # Display the occurrence of the phrase
    puts "The file contains the phrase \"#{phrase}\" #{ruby_occurrence} times."

  else
    # If the content does not contain the phrase, display an error message.
    puts "The file does not contain the phrase \"#{phrase}\".\n\n"

  end

else
  # If the file does not exist, display an error message.
  puts "The file #{input_file} not found.\n\n"
  
end



