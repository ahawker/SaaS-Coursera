#Andrew Hawker
#SaaS - Armando Fox & David Patterson (Spring 2012)
#Assignment 2 - Part 1
#http://spark-university.s3.amazonaws.com/berkeley-saas/homework/hw2.pdf


#(1a)
#Extended the currency-conversion example.
#Support for currencies: Dollar, Euro, Rupee, Yen (singular and plural forms).
class Numeric
  @@currencies = { 'dollar' => 1.000, 'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019 }
  
  def method_missing(method_id, *args, &block)
    exchange(method_id, false) or super
  end

  def in(currency)
    exchange(currency, true)
  end

  def exchange(currency, loss)
    currency = currency.to_s.gsub(/s$/, '')
    if @@currencies.has_key?(currency)
      rate = @@currencies[currency]
      return (loss) ? self/rate : self*rate
    end
  end
end


#(1b)
#Adopt palindrome soltuion from HW1 to work on strings.
#Ex: "foo".palindrome? # => false
class String
  def palindrome?
    return false if self.nil?
    s = self.gsub(/\W/, '').downcase
    s == s.reverse
  end
end

#(1c)
#Adapt palindrome solution to work on Enumerables.
#Ex: [1,2,3,2,1].palindrome # => true
module Enumerable
  def palindrome?
    return false if !self.to_a.respond_to?(:reverse)
    stoa = self.to_a
    stoa == stoa.reverse
  end
end
