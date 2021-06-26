require_relative 'number'

class Operation
    attr_accessor:number
  
    def initialize(number)
        @number = number
    end

    def +(obj)
        denominator = number.denominator * obj.denominator
        numerator =  denominator / number.denominator * number.numerator + denominator / obj.denominator * obj.numerator

        return Number.new(numerator, denominator)
    end

    def -(obj)
        denominator = number.denominator * obj.denominator
        numerator =  denominator / number.denominator * number.numerator - denominator / obj.denominator * obj.numerator

        return Number.new(numerator, denominator)
    end

    def *(obj)
        denominator = number.denominator * obj.denominator
        numerator =  number.numerator * obj.numerator

        return Number.new(numerator, denominator)
    end

    def /(obj)
        denominator = number.denominator * obj.numerator
        numerator =  number.numerator * obj.denominator

        return Number.new(numerator, denominator)
    end
end