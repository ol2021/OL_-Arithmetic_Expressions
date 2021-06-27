require './app/number'

describe Number do
    describe "#+" do
        context "Given simple sum of fractional operands" do
          it "returns true" do
            operand1 = Number.new(3,4)
            operand2 = Number.new(1,2)
            result = operand1 + operand2
            expect(result.numerator).to eql(10)
            expect(result.denominator).to eql(8)
          end
        end

        # context "Given simple valid expressions" do
        #   it "returns true" do
        #     str = "1 - 2"
        #     expr = Expr.new(str)
        #     expect(expr.run).to eql(true)
        #   end
        # end
    end

    # describe "#-" do
    #     context "Given simple valid expressions" do
    #       it "returns true" do
    #         str = "1 + 2"
    #         expr = Expr.new(str)
    #         expect(expr.run).to eql(true)
    #       end
    #     end

    #     context "Given simple valid expressions" do
    #       it "returns true" do
    #         str = "1 - 2"
    #         expr = Expr.new(str)
    #         expect(expr.run).to eql(true)
    #       end
    #     end
    # end

    # describe "#*" do
    #     context "Given simple valid expressions" do
    #       it "returns true" do
    #         str = "1 + 2"
    #         expr = Expr.new(str)
    #         expect(expr.run).to eql(true)
    #       end
    #     end

    #     context "Given simple valid expressions" do
    #       it "returns true" do
    #         str = "1 - 2"
    #         expr = Expr.new(str)
    #         expect(expr.run).to eql(true)
    #       end
    #     end
    # end

    # describe "#/" do
    #     context "Given simple valid expressions" do
    #       it "returns true" do
    #         str = "1 + 2"
    #         expr = Expr.new(str)
    #         expect(expr.run).to eql(true)
    #       end
    #     end

    #     context "Given simple valid expressions" do
    #       it "returns true" do
    #         str = "1 - 2"
    #         expr = Expr.new(str)
    #         expect(expr.run).to eql(true)
    #       end
    #     end
    # end
end