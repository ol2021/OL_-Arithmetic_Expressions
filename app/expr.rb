require 'aasm'
require_relative 'expression_tree'

class Expr

    include AASM

    def initialize(input_string)
      @input_string = input_string
      @tokens = []
      @slice = ''
      @is_operator_char = false
      @is_slash_char = false
      @is_underscore_char = false
    end

    def run
      while input_string.length > 0 do
        begin
          next_
        rescue AASM::InvalidTransition
          return false
        end
      end

      process_tokens
      true
    end

    def evaluate
      expr_tree.result
    end

    def print
      evaluate.representation
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

        after do
          self.slice += next_char unless is_space?
          reset_first_char

          if input_string.length == 0 # checking last character of the expression
            if digit? || non_zero_digit?
              raise AASM::InvalidTransition.new(self, 'error', :default) if incomplete_mixed_number?
              
              self.tokens.append(self.slice)
            elsif op? || negative_sign? || self.is_operator_char
              raise AASM::InvalidTransition.new(self, 'error', :default)
            end
          end
        end

        error do |e|
          puts "invalid expression"
          raise AASM::InvalidTransition.new(self,'error',:default)
        end

        transitions from: :start, to: :negative_sign do
          guard do
            is_negative_sign?
          end
        end

        transitions from: :start, to: :non_zero_digit do
          guard do
            non_zero?
          end
        end

        transitions from: [:non_zero_digit, :digit], to: :space do
          guard do
            is_space?
          end

          after do
            raise AASM::InvalidTransition.new(self,'error',:default) if incomplete_mixed_number?
            self.tokens.append(self.slice)
            self.slice = ''
            self.is_underscore_char = false
            self.is_slash_char = false
            self.is_operator_char = false
          end
        end

        transitions from: [:space, :op], to: :space do
          guard do
            is_space?
          end

          after do
            self.slice = ''
          end
        end

        transitions from: :space, to: :op do
          guard do
            is_operator? && !self.is_operator_char
          end

          after do
            self.slice = next_char
            self.tokens.append(self.slice)
            self.is_operator_char = true
          end
        end

        transitions from: [:space], to: :non_zero_digit do
          guard do
            non_zero?
          end
        end

        transitions from: [:space], to: :negative_sign do
          guard do
            is_negative_sign?
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
            is_underscore? && first_underscore_in_number?
          end

          after do
            self.is_underscore_char = true
          end
        end

        transitions from: [:digit,:non_zero_digit], to: :slash do
          guard do
            is_slash? && !self.is_slash_char
          end

          after do
            self.is_slash_char = true
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

    protected

    attr_accessor :tokens, :input_string, :slice, :is_operator_char, :is_underscore_char, :is_slash_char, :expression_tree

    private

    def expr_tree
      @expr_tree ||= ExpressionTree.new(tokens)
    end

    # linear time processing of token to avoid using - operation and getting negative results in the expression tree
    # -3 - 2 - 1 is transformed into -3 + -2 + -1
    def process_tokens
      i = 0
      while i < tokens.length do
        if tokens[i] == '-'
          if tokens[i+1][0] == '-'
            tokens[i+1][0] = ''
          else
            tokens[i+1].insert(0,'-')
          end
          tokens[i] = '+'
        end
        i += 1
      end
    end

    def next_char
      input_string[0]
    end

    def is_digit?
      next_char.count("^0-9").zero?
    end

    def non_zero?
      next_char.count("^1-9").zero?
    end

    def is_space?
      next_char.count("^ ").zero?
    end

    def is_negative_sign?
      next_char.count("^-").zero?
    end

    def is_underscore?
      next_char.count("^_").zero?
    end

    def is_slash?
      next_char.count("^/").zero?
    end

    def is_operator? # remove period
      next_char.count("^+-/*/").zero? && input_string[1] == ' '
    end

    def incomplete_mixed_number?
      self.is_underscore_char && !self.is_slash_char
    end

    def first_underscore_in_number?
      !self.is_underscore_char && !self.is_slash_char
    end

    def reset_first_char
      input_string[0] = ''
    end
end
