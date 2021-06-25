# spec/expr_spec.rb
# require './app/expr';e =Expr.new('(( 1 + 2)');e.run
require './app/expr'

# '((1 + (4) + (9/6 * 9_3/6)))'
# '((1 + (4))'

describe Expr do
    describe "#test" do
        context "given" do
          it "t1" do
            str = "1 + 2"
            expr = Expr.new(str)
            expect(expr.run).to eql(true)
          end

          it "t2" do
            str = "(1 + 2)"
            expr = Expr.new(str)
            expect(expr.run).to eql(true)
          end

          it "t3" do
            str = "(1 * 2) + 3"
            expr = Expr.new(str)
            expect(expr.run).to eql(true)
          end

          it "t4" do
            str = "()"
            expr = Expr.new(str)
            expect(expr.run).to eql(false)
          end

          it "t5" do
            str = "1_12"
            expr = Expr.new(str)
            expect(expr.run).to eql(true)
          end
        end
    end
end