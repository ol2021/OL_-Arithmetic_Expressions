require_relative 'expr'

expr = Expr.new('-3 - 2 - 1')
expr.run
puts(expr.print)