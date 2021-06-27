require 'aasm'
require_relative 'number.rb'
require 'pry'

class Expr
    attr_accessor:input_string#, :slice

    include AASM

    def initialize(input_string)
      @input_string = input_string
      @slice = ''
      @is_operator = false
      @has_underscore = false
      @has_slash = false
      @tokens = []
    end

    def tokens
      @tokens
    end

    def run
      while input_string.length > 0 do
        begin
          next_
        rescue RuntimeError
          return false
        end
      end
      true
    end
  
    aasm do
      state :start, initial: true
      state :digit
      state :non_zero_digit
      state :negative_sign
      state :op
      state :space
      state :underscore
      state :slash

      event :next_ do

        before do
          puts 'from ' + aasm.human_state
        end

        after do
          #binding.pry
          @slice += next_char if next_char != ' '
          input_string[0] = ''
          puts 'to ' + aasm.human_state

          if input_string.length == 0
            if digit? || non_zero_digit?
              puts ''

              raise RuntimeError if @has_underscore && !@has_slash

              puts "number: "+@slice
              @tokens.append(@slice)
            elsif op? || negative_sign? || @is_operator
              raise RuntimeError
            end
          end
        end

        error do |e|
          puts "invalid expression"
          raise RuntimeError
        end

        transitions from: :start, to: :negative_sign do
          guard do
            next_char == '-'
          end
        end

        transitions from: :start, to: :non_zero_digit do
          guard do
            #binding.pry
            non_zero?
          end
        end

        transitions from: [:non_zero_digit, :digit], to: :space do
          guard do
            space?
          end

          after do
            raise RuntimeError if @has_underscore && !@has_slash
            puts "number: "+@slice,''
            @tokens.append(@slice)
            @slice = ''
            @has_underscore = false
            @has_slash = false
            @is_operator = false
          end
        end

        transitions from: [:space, :op], to: :space do
          guard do
            space?
          end

          after do
            @slice = ''
          end
        end

        transitions from: :space, to: :op do
          guard do
            operator? && !@is_operator
          end

          after do
            @slice = next_char
            puts '',"operator: " + @slice,''
            @tokens.append(@slice)
            @is_operator = true
          end
        end

        transitions from: [:space], to: :non_zero_digit do
          guard do
            non_zero?
          end
        end

        transitions from: [:space], to: :negative_sign do
          guard do
            next_char == '-'
          end
        end

        transitions from: :non_zero_digit, to: :digit do
          guard do
            non_zero?
          end
        end

        transitions from: :negative_sign, to: :digit do
          guard do
            is_digit?
          end
        end

        transitions from: :negative_sign, to: :non_zero_digit do
          guard do
            non_zero?
          end
        end

        transitions from: :digit, to: :digit do
          guard do
            is_digit?
          end
        end

        transitions from: [:digit,:non_zero_digit], to: :underscore do
          guard do
            next_char == '_' &&  !@has_underscore && !@has_slash
          end

          after do
            @has_underscore = true
          end
        end

        transitions from: [:digit,:non_zero_digit], to: :slash do
          guard do
            next_char == '/' && !@has_slash
          end

          after do
            @has_slash = true
          end
        end

        transitions from: :slash, to: :non_zero_digit do
          guard do
            non_zero?
          end
        end

        transitions from: :underscore, to: :non_zero_digit do
          guard do
            non_zero?
          end
        end

        transitions from: :non_zero_digit, to: :digit do
          guard do
            is_digit?
          end
        end
      end
    end  

    private
    #attr_accessor:is_operator, :has_underscore, :has_slash

    def next_char
      input_string[0]
    end

    def is_digit?
      next_char.count("^0-9").zero?
    end

    def non_zero?
      next_char.count("^1-9").zero?
    end

    def space?
      next_char.count("^ ").zero?
    end

    def operator? # remove period
      next_char.count("^+-/*/").zero? && input_string[1] == ' '
    end
end
