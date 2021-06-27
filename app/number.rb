require 'pry'

class Number
    attr_accessor :numerator, :denominator

    # number is represented as fraction
    def initialize(numerator, denominator = 1)
        @numerator = numerator
        @denominator = denominator
    end

    # default sum
    # (a / b) + (c / d) = (da + bc)/bd
    def +(obj)
        denominator = self.denominator * obj.denominator
        numerator =  denominator / self.denominator * self.numerator + denominator / obj.denominator * obj.numerator

        return Number.new(numerator, denominator)
    end

    # default multi
    # (a / b) * (c / d) = ac/bd
    def *(obj)
        denominator = self.denominator * obj.denominator
        numerator =  self.numerator * obj.numerator

        return Number.new(numerator, denominator)
    end

    # default div
    # (a / b) / (c / d) = bc/ad
    def /(obj)
        denominator = self.denominator * obj.numerator
        numerator =  self.numerator * obj.denominator

        return Number.new(numerator, denominator)
    end

    def representation
        result = ""
        result += "-" if self.numerator * self.denominator < 0
        result += self.numerator.abs.to_s
        result += "/ #{self.denominator.abs.to_s}" if self.denominator.abs != 1
        result
    end
end

