require './app/expr'

describe Expr do
    describe "#run" do
        context "Given simple valid expressions" do
          it "returns true" do
            str = "1 + 2"
            expr = Expr.new(str)
            expect(expr.run).to eql(true)
          end

          it "returns true" do
            str = "1 - 2"
            expr = Expr.new(str)
            expect(expr.run).to eql(true)
          end

          it "returns true" do
            str = "-1 * 2 + 3"
            expr = Expr.new(str)
            expect(expr.run).to eql(true)
          end

          it "returns true" do
            str = "-2/4"
            expr = Expr.new(str)
            expect(expr.run).to eql(true)
          end

          it "returns true" do
            str = "2/4"
            expr = Expr.new(str)
            expect(expr.run).to eql(true)
          end

          it "returns true" do
            str = "-2_3/4"
            expr = Expr.new(str)
            expect(expr.run).to eql(true)
          end

          it "returns true" do
            str = "1_12/6"
            expr = Expr.new(str)
            expect(expr.run).to eql(true)
          end

          it "returns true" do
            str = "1 + 2 * 3 + 4"
            expr = Expr.new(str)
            expect(expr.run).to eql(true)
          end

          it "returns true combining improper, " do
            str = "1/6 / 2_6/7 * 3 + 4 - 5_9/6"
            expr = Expr.new(str)
            expect(expr.run).to eql(true)
          end
        end

        context "Given invalid expressions" do
          it "returns false with an invalid number" do
            str = "5/6/6"
            expr = Expr.new(str)
            expect(expr.run).to eql(false)
          end

          it "returns false with invalid format" do
            str = "5+6/6"
            expr = Expr.new(str)
            expect(expr.run).to eql(false)
          end

          it "returns false with invalid number format" do
            str = "5/6_3"
            expr = Expr.new(str)
            expect(expr.run).to eql(false)
          end
        end
    end
end