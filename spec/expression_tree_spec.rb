require './app/expression_tree'
require './app/math_utils'

describe ExpressionTree do
    describe "#initialize" do
        context "When a multiple hierarchy expression of operators given" do
            it "returns reduced fraction" do
            expr_tree = described_class.new(['4','+','2','*','3'])
            value = MathUtils.reduce_fraction(expr_tree.calculate)
            expect(value.numerator).to eql(10)
            expect(value.denominator).to eql(1)
            end

            it "returns reduced fraction" do
            expr_tree = described_class.new(['4','*','2','+','10', '/', '5'])
            value = MathUtils.reduce_fraction(expr_tree.calculate)
            expect(value.numerator).to eql(10)
            expect(value.denominator).to eql(1)
            end
        end

        context "When mixed hierarchy with mixed numbers and fractionals are given" do
            it "returns reducen fraction" do
            expr_tree = described_class.new(['9/3','*','2_5/2','+','10', '/', '5/5'])
            value = MathUtils.reduce_fraction(expr_tree.calculate)
            expect(value.numerator).to eql(25)
            expect(value.denominator).to eql(1)
            end
        end
    end

    describe "#process_number" do
        context "When a whole or integer number is given" do
            it "returns whole number" do
            number = described_class.process_number('4234')

            expect(number.numerator).to eql(4234)
            expect(number.denominator).to eql(1)
            end
        end

        context "When a whole and denominator are given" do
            it "return fractional number" do
            number = described_class.process_number('42/34')

            expect(number.numerator).to eql(42)
            expect(number.denominator).to eql(34)
            end
        end

        context "When a mixed number is given" do
            it "returns fractional number" do
            number = described_class.process_number('4_2/34')

            expect(number.numerator).to eql(8)
            expect(number.denominator).to eql(34)
            end
        end
    end
end

