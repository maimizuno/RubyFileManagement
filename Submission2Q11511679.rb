# ----------------------------------------------------------------------------------------------------
# Submission 2 Q1
# Student ID: S1511679
# Name: Mai Mizuno
#
# Description:
# The script is designed to search for SSNs in .docx documents within a specified
# directory and its sub-directories. The search result will be stored in a new file
# named "result.txt" with the found date.
#
# ----------------------------------------------------------------------------------------------------
require 'search_in_file'

# The class contains methods to perform a SSN search and store the result in a txt file
class SSN_1511679

  # constructor - initialise variables
  def initialize(dir)
    @ssn_dir = dir # target directory
    @result = {} # search result of the directory
  end

  # SSN search function
  def search_1511679
    # initialise local variables
    ssn_pattern = /\b[A-Za-z0-9]{3}-[A-Za-z0-9]{2}-[A-Za-z0-9]{4}\b/ # SSN format: xxx-xx-xxxx (x: alphanumeric, no special chars)
    total_occ = 0 # total numbers of SSN occurrence with 0
    # search for all .docx files in the dir and sub-dirs and store the objs in the array
    docx_array = SearchInFile.find_by_type_in(@ssn_dir, ".docx")

    # iterate over each element(file) in the array(docx)
    docx_array.each do |file|
      # extract the content of the current file
      content = SearchInFile.content_of(file)
      # check if content contains the ssn pattern
      if content =~ ssn_pattern
        # extract all matches of a pattern in the content and store the ssns in the array
        ssn_array = content.scan(ssn_pattern)
        # store the results in the hash (key: file path, values: unique SSNs and SSN occurence in each file)
        @result[file] = [ssn_array.uniq, ssn_array.length]
        # Add the current SSN occurrence to the total
        total_occ += ssn_array.length
      end
    end

    # print the result
    puts "\n[Result]"
    puts "#{@result.length} docx files containing SSNs found in the folder." # total numbers of SSN related files

    @result.each do |key, value|
      puts "\tFile: #{key}, SSN occurrence: #{value[1]}" # file path & SSN occurrence
    end

    puts "#{total_occ} SSNs found in total.\n\n" # total numbers of SSN occurrence
    puts "The result is stored in the result.txt file."

  end

  # result.txt generation/appending
  def write_1511679

    # get the current date & time
    current_date = Time.now.strftime("%d/%m/%Y %H:%M:%S")

    # open the file in append mode
    File.open("result.txt", "a") do |file|
      # check if the result hash is empty
      if @result.empty?
        # write the result (No SSNs found) on the txt file
        file.puts "There is no SSNs found in all word documents in the given directory.\n\n"
        file.puts "Searched date: #{current_date}"
      else
        i = 1 # line counter
        # iterate over each key-value pair in the hash
        @result.each do |key, value|
          f_name = File.basename(key) # extract the file name from the path
          # iterate over each SSN in the array within the hash
          value[0].each do |ssn|
            file.puts " #{i}. #{ssn} #{f_name}" # write the SSN and its corresponding file name with the line number
            i += 1 # increment the line counter
          end
        end
        file.puts "Found date: #{current_date}\n\n" # log the date & time
      end
    end
  end

end

# Main Script Logic --------------------------------------------------------------------------------

# loop until the valid folder path is provided
loop do
  # prompt a user to enter a folder path for searching SSNs
  puts "\nPlease type the target directory to search for SSNs and press Enter:"
  puts "(e.g. \"C:\\Users\\Name\\RubymineProjects\\Assessment2\")"

  # get a user input e.g."C:/Users/UniMa/RubymineProjects/SSN"
  dir = STDIN.gets.chomp # remove the new line characters or spaces and store the input in dir
  dir.gsub!("\"", "") if dir =~ /"/ # if the path contains "", remove them

  begin
    # check if the provided path is valid
    if File.directory?(dir)
      ssn_search = SSN_1511679.new(dir) # if valid, create an instance of the SSN class
      ssn_search.search_1511679 # call the method to search for SSNs
      ssn_search.write_1511679 # call the method to write the search result
      break # break the loop after a successful search and result generation

    # if the path exists but it's not a directory, print an error message
    elsif File.exist?(dir)
      puts "#{dir} is not a folder path.\n\n"

    # if the path is not found, print an error message
    else
      puts "The directory not found.\n\n"
    end

  # handle "No such file or directory" errors
  rescue Errno::ENOENT
    puts "The directory does not exist. Please check the path and try again."
  # handle other errors
  rescue StandardError => e
    puts "An error occurred: #{e.message}. Please try again."
  end

end
