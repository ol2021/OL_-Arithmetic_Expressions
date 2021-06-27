require_relative 'expression_tree'
require_relative 'expr'
require_relative 'math_utils'
require 'pry'

#expr = Expr.new('1/6 * 2_5/6 + 3/6 - 4')
expr = Expr.new('4 * 2 + 10 / 5')
expr.run
puts expr.tokens

expr_tree = ExpressionTree.new(expr.tokens)
#result = expr_tree.calculate(expr_tree.tree)
result = expr_tree.calculate()
result.representation
result = MathUtils.reduce_fraction(result)
result.representation

# number = Number.new(10,2)
# MathUtils.reduce_fraction(number)