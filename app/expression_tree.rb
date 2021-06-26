require_relative 'tree_node'

class ExpressionTree

    OPERATORS = %w[+ -]

    def initialize(tokenList)
        @tokenList = tokenList
        @spaces = @tokenList.count
    end

    def tokenList
        @tokenList
    end

    def create(tokens = tokenList)
        
        if tokens.count == 1
            return TreeNode.new(tokens.first)
        elsif tokens.count == 3
            left = TreeNode.new(tokens.first)
            parent = TreeNode.new(tokens[1])
            right = TreeNode.new(tokens.last)

            parent.left = left
            parent.right = right
            return parent
        else
            expr = []
            while ! OPERATORS.include?(tokens.first) do
                expr.append(tokens.first)
                tokens.delete_at(0)
            end

            op = tokens.first
            tokens.delete_at(0)
            #puts "left " + expr.to_s + " op " + op.to_s + " right " + tokens.to_s

            left = create(expr)
            parent = TreeNode.new(op)
            right = create(tokens)

            parent.left = left
            parent.right = right

            return parent
        end        
    end


    private

    def print_tree(head, order)
        if head.left.nil? && head.right.nil?
            order.push(head.value)
        else
            print_tree(head.left,order) if head.left
            order.append(head.value)
            print_tree(head.right,order) if head.right
        end
    end

end

