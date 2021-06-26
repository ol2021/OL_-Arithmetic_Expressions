require './app/expr'

describe Expr do
    describe "#run" do
        context "given" do
          it "t1" do
            str = "1 + 2 "
            expr = Expr.new(str)
            expect(expr.run).to eql(true)
          end

          it "t2" do
            str = "1 - 2"
            expr = Expr.new(str)
            expect(expr.run).to eql(true)
          end

          it "t3" do
            str = "-1 * 2 + 3"
            expr = Expr.new(str)
            expect(expr.run).to eql(true)
          end

          it "t4" do
            str = "-2/4"
            expr = Expr.new(str)
            expect(expr.run).to eql(true)
          end

          it "t543" do
            str = "2/4"
            expr = Expr.new(str)
            expect(expr.run).to eql(true)
          end

          it "t543" do
            str = "-2_3/4"
            expr = Expr.new(str)
            expect(expr.run).to eql(true)
          end

          it "t5" do
            str = "1_12/6"
            expr = Expr.new(str)
            expect(expr.run).to eql(true)
          end

          it "t7" do
            str = "1 + 2 * 3 + 4"
            expr = Expr.new(str)
            expect(expr.run).to eql(true)
          end

          it "t8" do
            str = "1/6 / 2_6/7 * 3 + 4 - 5_9/6"
            expr = Expr.new(str)
            expect(expr.run).to eql(true)
          end
        end

        context "given" do
          it "tsd" do
            str = "5/6/6"
            expr = Expr.new(str)
            expect(expr.run).to eql(false)
          end

          it "tfdsf" do
            str = "5+6/6"
            expr = Expr.new(str)
            expect(expr.run).to eql(false)
          end

          it "tfdsfds" do
            str = "5/6_3"
            expr = Expr.new(str)
            expect(expr.run).to eql(false)
          end
        end
    end
end