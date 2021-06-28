require_relative 'expr'

expr = Expr.new('10 * 9 * 9')
expr.run
puts expr.print 