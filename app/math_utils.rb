class MathUtils
    def self.gdc(a,b)
        k = b % a
        return 1 if k == 1
        return a if k == 0
        return self.gdc(k,a)
    end

    def self.reduce_fraction(number)
        max = (number.numerator..number.denominator).max
        min = (number.numerator..number.denominator).min
        gdc = self.gdc(min,max)
        
        number.numerator /= gdc
        number.denominator /= gdc
        return number
    end
end