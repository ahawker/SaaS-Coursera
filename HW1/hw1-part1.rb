#Andrew Hawker
#SaaS - Armando Fox & David Patterson (Spring 2012)
#Assignment 1 - Part 1
#http://spark-university.s3.amazonaws.com/berkeley-saas/homework/hw1.pdf

#(1a)
#Write a method that determines whether a given word or phrase is
#a palindrome, that is, it reads the same backwards as forwards, ignoring
#case, punctuation, and nonword characters.
def palindrome?(string)
  return false if string.nil?

  s = string.gsub(/\W/, '')
  srev = s.reverse
  eq = s.casecmp srev
  eq == 0
end

#(1b)
#Given a string of input, return a hash whose keys are words in the string
#and whos values are the number of times each word appears.
def count_words(string)
  return nil if string.nil?

  w = string.split(/\b/).map {|x| x.gsub(/[\W]+/, '').downcase}.reject {|x| x.empty?}
  Hash[w.map {|x| [x, w.select {|y| x == y}.size]}]
end
