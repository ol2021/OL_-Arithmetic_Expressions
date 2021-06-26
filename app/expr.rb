require 'aasm'
require_relative 'operator.rb'
require_relative 'number.rb'
require 'pry'

class Expr
    include AASM

    def initialize(input_string)
      @input_string = input_string
      @tokens = []

      @opened = 0
      @closed = 0
      @expresion = false
      @is_operator = false
      @number = nil
      @slice = ''
      @error = nil

      @has_underscore = false
      @has_slash = false
    end

    def tokens
      @tokens
    end

    def input_string
      @input_string
    end

    def error
      @error
    end

    def run
      while input_string.length > 0 do
        begin
          next_
        rescue RuntimeError
          return false
        end
      end
      puts tokens
      true
    end
  
    aasm do
      state :start, initial: true
      state :digit
      state :slash
      state :negative_sign
      state :underscore
      state :non_zero_digit
      state :op
      state :space
      state :open_parenthesis
      state :close_parenthesis
  
      event :next_ do

        before do
          #puts 'from ' + aasm.human_state
        end

        after do
          @slice += @input_string[0] if @input_string[0] != ' '
          @input_string[0] = ''
          #puts 'to ' + aasm.human_state

          if input_string.length == 0
            if close_parenthesis?
              raise RuntimeError unless balanced_expression?
              puts ''
              puts '',"expresion: " + @slice,'' if @expresion
              tokens.append(@slice) if @expresion
              @slice = '' if @expresion
              @expresion = false
            
            elsif digit? || non_zero_digit?
              puts ''

              raise RuntimeError if @has_underscore && !@has_slash

              puts "number: "+@slice unless @expresion
              tokens.append(@slice) unless @expresion
            elsif op? || negative_sign? || @is_operator
              raise RuntimeError
            end
          end
        end

        error do |e|
          puts "invalid expression"
          raise RuntimeError
        end

        transitions from: :start, to: :open_parenthesis do
          guard do
            opened_parenthesis? && @opened + 1 >= @closed 
          end

          after do
            @expresion = true if !@expresion
            @opened += 1
          end
        end

        #### added
        transitions from: :start, to: :negative_sign do
          guard do
            input_string[0] == '-'
          end
        end

        transitions from: :start, to: :space
        transitions from: :start, to: :non_zero_digit do
          guard do
            non_zero?
          end
        end

        transitions from: [:non_zero_digit, :digit], to: :space do
          guard do
            space?
          end

          after do
            raise RuntimeError if @has_underscore && !@has_slash
            puts ''
            puts "number: "+@slice,'' if !@expresion
            tokens.append(@slice) if !@expresion
            @slice = '' if !@expresion
            @has_underscore = false
            @has_slash = false
            @is_operator = false
          end
        end

        transitions from: [:space, :op, :open_parenthesis], to: :space do
          guard do
            # puts "space"
            space?
          end

          after do
            @slice = '' if !@expresion
          end
        end

        transitions from: :close_parenthesis, to: :space do
          guard do
            space?
          end

          after do
            if balanced_expression?
              puts '',"expresion: " + @slice,'' if @expresion
              tokens.append(@slice) if @expresion
              
              @slice = ''
              @expresion = false
            end
          end
        end

        transitions from: :space, to: :op do
          guard do
            operator? && !@is_operator
          end

          after do
            @slice = @input_string[0] if !@expresion
            puts '',"operator: " + @slice,'' if !@expresion
            tokens.append(@slice) if !@expresion
            @is_operator = true
          end
        end

        transitions from: [:space, :open_parenthesis], to: :non_zero_digit do
          guard do
            non_zero?
          end
        end

        #### added
        transitions from: [:space, :open_parenthesis], to: :negative_sign do
          guard do
            input_string[0] == '-'
          end
        end

        transitions from: :non_zero_digit, to: :digit do
          guard do
            non_zero? #?
          end
        end

        ## added
        transitions from: :negative_sign, to: :digit do
          guard do
            is_digit?
          end
        end

        # added
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
            @input_string[0] == '_' &&  !@has_underscore && !@has_slash
          end

          after do
            @has_underscore = true
          end
        end

        transitions from: [:digit,:non_zero_digit], to: :slash do
          guard do
            @input_string[0] == '/' && !@has_slash
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

        transitions from: [:space, :op, :open_parenthesis], to: :open_parenthesis do
          guard do
            opened_parenthesis? && @opened + 1 >= @closed 
          end

          after do
            @expresion = true if !@expresion
            @opened += 1
          end
        end

        transitions from: [:space, :op, :close_parenthesis, :digit, :non_zero_digit], to: :close_parenthesis do
          guard do
            puts input_string,@has_underscore && !@has_slash
            raise RuntimeError if @has_underscore && !@has_slash
            closed_parenthesis? && @opened + 1 >= @closed  && @expresion
          end

          after do
            @closed += 1
            if @has_slash || @has_underscore
              @has_underscore = false
              @has_slash = false
            end
          end
        end
      end
    end  

    def is_digit?
      @input_string[0].count("^0-9").zero?
    end

    def non_zero?
      @input_string[0].count("^1-9").zero?
    end

    def space?
      @input_string[0].count("^ ").zero?
    end

    def operator? # remove period
      @input_string[0].count("^+-/*/").zero? && @input_string[1] == ' '
    end

    def opened_parenthesis?
      @input_string[0].count("^(").zero?
    end

    def closed_parenthesis?
      @input_string[0].count("^)").zero?
    end

    def valid?
      @opened >= @closed
    end

    def balanced_expression?
      (@opened == @closed) && @expresion
    end
end
