require_relative 'tree_node'
require_relative 'number'
require_relative 'math_utils'

class ExpressionTree

    attr_accessor :tree

    OPERATORS = %w[+ -]

    def initialize(tokens)
        @tokens = tokens
        @tree = create_tree(@tokens)
        
    end

    def result
        MathUtils.reduce_fraction(calculate)
    end

    # parses and determine which case is (whole number (integer), proper or inpromer fractions)
    def self.process_number(number_string)
        numbers = number_string.split(/[_\/]/)
        
        whole = numbers.first.to_i
        denominator = 1

        whole = whole * numbers.last.to_i + numbers[1].to_i if numbers.count == 3 # mixed number
        denominator = numbers.last.to_i if numbers.count > 1 # with slash (fractional)
         
        return Number.new(whole, denominator)
    end

    private

    def create_tree(tokens = self.tokens)
        if tokens.count == 1 # base case when only have a number
            return TreeNode.new(tokens.first)
        elsif tokens.count == 3 # base case when we have two operands and an operator since this is a valid expression
            left = TreeNode.new(tokens.first)
            parent = TreeNode.new(tokens[1]) # parent is always an operator
            right = TreeNode.new(tokens.last)

            parent.left = left
            parent.right = right
            return parent
        else
            expr = []
            while ! OPERATORS.include?(tokens.first) do # traverse until an operator appears 
                expr.append(tokens.first)
                tokens.delete_at(0)
            end

            operator = tokens.first
            tokens.delete_at(0)

            # construct and return the tree / subtree
            left = create_tree(expr)
            parent = TreeNode.new(operator)
            right = create_tree(tokens)

            parent.left = left
            parent.right = right

            return parent
        end        
    end

    # given an expression tree root, gets the actual result
    def calculate(node = self.tree)

        # base case when a leaf is reached (number) 
        return ExpressionTree.process_number(node.value) if node.left.nil? && node.right.nil?

        left = Number.new(0)
        if node.left
            left = calculate(node.left)
        end

        right = Number.new(0)
        if node.left
            right = calculate(node.right)
        end

        # using send to pass the actual operator and evaluate ir using overloading of operators
        return left.send(node.value,right)   
    end

    private

    attr_accessor :tokens

end

