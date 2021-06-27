require './app/math_utils'
require './app/number'

describe MathUtils do
    describe "#gcd" do
        context "when 2 integer numbers have a gcd greater than 1" do
          it "returns true when proper result values given" do
            
            # gdc(10842. 48932) = 26
            expect(described_class.gcd(10842,48932)).to eql(26)
          end
        end

        context "when 2 integer numbers have a gcd greater equals 1" do
          it "returns true when proper result values given" do
            
            # gdc(3, 20) = 1
            expect(described_class.gcd(3,20)).to eql(1)
          end
        end
    end

    describe "#reduce_fraction" do
        context "When given a non simplified fraction" do
          it "returns a simplified fraction" do
            
            # 63/56 = 9/8 
            number = Number.new(63,56)
            result = described_class.reduce_fraction(number)
            expect(result.numerator).to eql(9)
            expect(result.denominator).to eql(8)
          end
        end
    end
end

