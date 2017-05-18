load 'TinyToken.rb'
load 'TinyScanner.rb'

# Information gathered from http://ruby-doc.org/core-2.4.0/File.html
# Style guide from https://github.com/bbatsov/ruby-style-guide

# filename.txt below is simply the "source code"
# that you write that adheres to your grammar rules
# if it is in the same directory as this file, you can
# simply include the file name, otherwise, you will need
# to specify the entire path to the file as we did above
# to load the other ruby modules
if File.exist?('input.txt')
  scan = Scanner.new('input.txt')
  output = File.open('output.txt', 'w')
  tok = scan.next_token

  while tok.get_type != Token::EOF
    puts "Token: #{tok} type: #{tok.get_type}"
    output.write("Token: #{tok} type: #{tok.get_type} \n")
    tok = scan.next_token
  end

  puts "Token: #{tok} type: #{tok.get_type}"
  output.write("Token: #{tok} type: #{tok.get_type} \n")
  output.close

else
  puts 'The selected file does not exist.'
end