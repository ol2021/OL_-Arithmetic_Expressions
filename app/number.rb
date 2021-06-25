class Number
    def initialize(a,b=1)
        @numerator = a
        @denominator = b
    end

    def representation
        puts @numerator + '/' + @denominator
    end
end

