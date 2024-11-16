# ------------------------------------------------------
# Author: Mai Mizuno
# Description:
# The script prompts a user to type a folder path/name and checks if it exists.
# If the folder exists, the program allows the user to view the folder contents.
# If it doesn't exist, the program displays an error message.
# ------------------------------------------------------

# A. Prompt the user to type the path and name of a folder whose contents will be displayed.
puts "Please type your folder path (including the folder name) and press Enter:"
puts "\te.g. \"C:\\Users\\Name\\RubymineProjects\\FolderName\""
puts "\t* In this case, \"Assessment2\" is the folder name.\n\n"

# B. Capture the user input of the folder path/name
path1511679 = STDIN.gets.chomp
path1511679.gsub!("\"", "") if path1511679 =~ /"/  # If the path contains "", remove ""
folder1511679 = File.basename(path1511679)  # Extract the last component(folder name) of the folder path

# B. Check if the folder exists
if File.directory?(path1511679)
  # C. If the folder exists, display a confirmation message
  puts "\nThe folder #{folder1511679} found."
  # D. Prompt the user to press Enter in order to view the folder contents
  puts "To View the contents, press Enter:"
  gets  #Wait for the user to press Enter

  Dir.foreach(path1511679) do |content| #Iterate over each content in the directory
    next if content == "." or content == ".." #If content includes . or .., skip them
    puts content  #Print the content in the folder
  end

else
  # E (and C). If the folder does not exist, display an error message. *
  puts "The folder #{folder1511679} not found.\n\n"
end


