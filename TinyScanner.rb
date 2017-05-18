# https://www.cs.rochester.edu/~brown/173/readings/05_grammars.txt
#
#  "TINY" Grammar
#
# PGM        -->   STMT+
# STMT       -->   ASSIGN   |   "print"  EXP
# ASSIGN     -->   ID  "="  EXP
# EXP        -->   TERM   ETAIL
# ETAIL      -->   "+" TERM   ETAIL  | "-" TERM   ETAIL | EPSILON
# TERM       -->   FACTOR  TTAIL
# TTAIL      -->   "*" FACTOR TTAIL  | "/" FACTOR TTAIL | EPSILON
# FACTOR     -->   "(" EXP ")" | INT | ID   
#                  
# ID         -->   ALPHA+
# ALPHA      -->   a  |  b  | … | z  or 
#                  A  |  B  | … | Z
# INT        -->   DIGIT+
# DIGIT      -->   0  |  1  | …  |  9
# WHITESPACE -->   Ruby Whitespace

# Comment out the below line when not using the IDE for editing...
load 'TinyToken.rb'

#
#  Class Scanner - Reads a TINY program and emits tokens
#
class Scanner
# Constructor - Is passed a file to scan and outputs a token
#               each time nextToken() is invoked.
#   @c_look        - A one character lookahead
  def initialize(filename)
    if File.exist?(filename)
      @file = File.open(filename, 'r:utf-8')

      if !@file.eof?
       @c_look = @file.getc
      else
        @c_look = '!eof!'
        @file.close
      end
    else
      puts 'File does not exist or cannot be opened.'
      @c_look = '!eof!'
    end
  end

  # Method next_ch returns the next character in the file
  def next_ch
    @c_look =
      if !@file.eof?
        @file.getc
      else
        '!eof!'
      end
  end

  # Method next_token reads characters in the file and returns
  # the next token
  def next_token
    if @c_look == '!eof!'
      Token.new(Token::EOF, '!eof!')

    elsif whitespace?(@c_look)
      str = ''
      while whitespace?(@c_look)
        str += @c_look
        next_ch
      end

      Token.new(Token::WHITESPACE, str)

    elsif letter?(@c_look)
      str = ''
      while letter?(@c_look)
        str += @c_look
        next_ch
      end

      if str == 'print'
        Token.new(Token::PRINT, str)
      else
        Token.new(Token::IDENT, str)
      end

    elsif numeric?(@c_look)
      str = ''
      while numeric?(@c_look)
        str += @c_look
        next_ch
      end

      Token.new(Token::INT, str)

    elsif @c_look == '='
      next_ch
      Token.new(Token::ASSIGN, '=')

    elsif @c_look == '('
      next_ch
      Token.new(Token::LPAREN, '(')

    elsif @c_look == ')'
      next_ch
      Token.new(Token::RPAREN, ')')

    elsif @c_look == '+'
      next_ch
      Token.new(Token::ADDOP, '+')

    elsif @c_look == '-'
      next_ch
      Token.new(Token::SUBOP, '-')

    elsif @c_look == '*'
      next_ch
      Token.new(Token::MULTOP, '*')

    elsif @c_look == '/'
      next_ch
      Token.new(Token::DIVOP, '/')

    else
      next_ch
      # don't want to give back nil token!
      # remember to include some case to handle
      # unknown or unrecognized tokens.
      Token.new('unknown', 'unknown')
    end
  end

  #
  # Helper methods for Scanner
  #
  def letter?(look_ahead)
    look_ahead =~ /^[a-z]|[A-Z]$/
  end

  def numeric?(look_ahead)
    look_ahead =~ /^(\d)+$/
  end

  def whitespace?(look_ahead)
    look_ahead =~ /^(\s)+$/
  end

end
