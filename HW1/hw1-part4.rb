#Andrew Hawker
#SaaS - Armando Fox and David Patterson (Spring 2012)
#Assignment 1 - Part 4
#http://spark-university.s3.amazonaws.com/berkeley-saas/homework/hw1.pdf

#(4a)
class Dessert
  attr_accessor :name, :calories

  def initialize(name, calories)
    @name = name
    @calories = calories
  end

  def healthy?
    @calories < 200
  end

  def delicious?
    true
  end
end

#(4b)
class JellyBean < Dessert
  attr_accessor :flavor

  def initialize(name, calories, flavor)
    super(name, calories)
    @flavor = flavor
  end

  def delicious?
    @flavor.downcase == "black licorice" ? false : super
  end
end
