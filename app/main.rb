require_relative 'expr'
require "tty-prompt"

prompt = TTY::Prompt.new

str = ''

# examples
# expr = Expr.new('10 * 10 * 100 * 1000 * 10000 * 100000 * 1000000 * 10000000 * 100000000 * 1000000000')
# expr = Expr.new('1 * 2 + 3 * 4 + 5')


while str != 'exit' do
    str = prompt.ask("ENTER AN EXPRESSION OR EXIT", default: '')
    expr = Expr.new(str) if ! str.empty?
    
    next if expr.nil?
    puts expr.print if expr.run
end

