# This class represents a simple binary tree node for
# further evaluation in a expression tree

class TreeNode
    attr_accessor :value, :left, :right
    
    # token represents either operator or operand
    def initialize(token)
        @value = token
        @left = nil
        @right = nil
    end
end
