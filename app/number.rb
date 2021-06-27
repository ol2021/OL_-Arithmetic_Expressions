class Number
    attr_accessor :numerator, :denominator

    def initialize(numerator, denominator = 1)
        @numerator = numerator
        @denominator = denominator
    end

    def +(obj)
        denominator = self.denominator * obj.denominator
        numerator =  denominator / self.denominator * self.numerator + denominator / obj.denominator * obj.numerator

        return Number.new(numerator, denominator)
    end

    def -(obj)
        denominator = self.denominator * obj.denominator
        numerator =  denominator / self.denominator * self.numerator - denominator / obj.denominator * obj.numerator

        return Number.new(numerator, denominator)
    end

    def *(obj)
        denominator = self.denominator * obj.denominator
        numerator =  self.numerator * obj.numerator

        return Number.new(numerator, denominator)
    end

    def /(obj)
        denominator = self.denominator * obj.numerator
        numerator =  self.numerator * obj.denominator

        return Number.new(numerator, denominator)
    end

    def representation
        sign = ''
        sign = '-' if self.numerator * self.denominator < 0 
        puts sign + self.numerator.abs.to_s + '/' + self.denominator.abs.to_s
    end
end

