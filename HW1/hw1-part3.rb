#Andrew Hawker
#SaaS - Armando Fox and David Patterson (Spring 2012)
#Assignment 1 - Part 3
#http://spark-university.s3.amazonaws.com/berkeley-saas/homework/hw1.pdf

#(3a)
#Given a list of words, return an array of anagram groups.
#Case should be preserved.
#Order of anagram groups does not matter.
def combine_anagrams(words)
  return [] if words.nil?
  return [] if words.length == 0

  h = Hash[]
  words.each {|x|
    s = x.strip.downcase.chars.sort.join
    if !h.has_key?(s)
      h[s] = [x]
    else
      h[s].push(x)
    end
  }
  h.values
end
