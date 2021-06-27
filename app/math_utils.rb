class MathUtils

    # euclidian algorithm for a gcd of two integer numbers
    def self.gcd(a,b)
        k = b % a
        return 1 if k == 1
        return a if k == 0
        return self.gcd(k,a)
    end

    # to reduce as much as possible a fractional number
    def self.reduce_fraction(number)
        max = [number.numerator, number.denominator].max
        min = [number.numerator, number.denominator].min
        gdc = self.gcd(min,max)
        
        number.numerator /= gdc
        number.denominator /= gdc
        return number
    end
end