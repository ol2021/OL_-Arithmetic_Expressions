# spec/expr_spec.rb
# require './app/expr';e =Expr.new('(( 1 + 2)');e.run
# require './app/expr';e =Expr.new('2_1/6 - ((1 + 2) + 2_3/7 * 6/5) 9/7 + (7_3/5 / 54353)');e.run
# require './app/expr';e =Expr.new('-1 + 2');e.run
require './app/expr'

# '((1 + (4) + (9/6 * 9_3/6)))'
# '((1 + (4))'
# 2_1/6 - ((1 + 2) + 2_3/7 * 6/5) 9/7 + (7_3/5 / 53)' ok
# 2_1/6 - ((1 + 2) + 2_3/7 * 6/5) 9//7 + (7_3/5 / 53)' error
# 2_1/6 - ((1 + 2) + 2_3/7 * 6/5) 9/7/6 + (7_3/5 / 553)' error
# 2/1_6 - ((1 + 2) + 2_3/7 * 6/5) 9/7 + (7_3/5 / 543)' error
# 2/1_6 - ((1 + 2) + 2_3/7 * 6/5) 9/7 + (7_3/5 / 543)' error
# 2_1/6 - (1 + 2_3/6 * 4/6 - 5 + 5_3/5 * 3 - 4/45 + 56_4/4' ok

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