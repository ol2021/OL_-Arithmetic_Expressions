require_relative 'expression_tree'
require_relative 'expr'
require_relative 'math_utils'

expr = Expr.new('1/6 * 2_5/6 + 3/6 - 4')
expr.run
puts expr.tokens
expr_tree = ExpressionTree.new(expr.tokens)
result = expr_tree.calculate(expr_tree.tree)
result.representation
result = MathUtils.reduce_fraction(result)
result.representation
