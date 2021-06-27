require './app/number'

describe Number do
    describe "#+" do
        context "Given simple sum of fractional operands" do
          it "returns true when proper result values given" do
            operand1 = Number.new(3,4)
            operand2 = Number.new(1,2)
            result = operand1 + operand2

            # 3/4 + 1/2 = 10/8
            expect(result.numerator).to eql(10)
            expect(result.denominator).to eql(8)
          end
        end
    end

    describe "#-" do
        context "Given simple substraction of fractional operands" do
          it "returns true when proper result values given" do
            operand1 = Number.new(3,4)
            operand2 = Number.new(1,2)
            result = operand1 - operand2

            # 3/4 - 1/2 = 2/8
            expect(result.numerator).to eql(2)
            expect(result.denominator).to eql(8)
          end
        end
    end

    describe "#*" do
        context "Given simple multiplication of fractional operands" do
          it "returns true when proper result values given" do
            operand1 = Number.new(3,4)
            operand2 = Number.new(1,2)
            result = operand1 * operand2

            # 3/4 * 1/2 = 3/8
            expect(result.numerator).to eql(3)
            expect(result.denominator).to eql(8)
          end
        end
    end

    describe "#/" do
        context "Given simple division of fractional operands" do
          it "returns true when proper result values given" do
            operand1 = Number.new(3,4)
            operand2 = Number.new(1,2)
            result = operand1 / operand2

            # 3/4 / 1/2 = 6/4
            expect(result.numerator).to eql(6)
            expect(result.denominator).to eql(4)
          end
        end
    end
end

