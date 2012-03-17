#Andrew Hawker
#SaaS - Armando Fox & David Patterson (Spring 2012)
#Assignment 2 - Part 2
#http://spark-university.s3.amazonaws.com/berkeley-saas/homework/hw2.pdf


#(2)
#Return an iterator that generates the Cartesian Product of two collections.
class CartesianProduct
  include Enumerable

  def initialize(a, b)
    @a = a
    @b = b
  end

  def each
    return [] if @a.nil? or @a.length == 0
    return [] if @b.nil? or @b.length == 0

    @a.each { |x| 
      @b.each { |y| 
        yield x, y
      }
    }
  end
end
