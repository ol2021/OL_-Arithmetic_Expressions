require_relative 'expr'

#expr = Expr.new('10 * 10 * 100 * 1000 * 10000 * 100000 * 1000000 * 10000000 * 100000000 * 1000000000')
expr = Expr.new('1 * 2 + 3 * 4 + 5')
expr.run
puts expr.print 