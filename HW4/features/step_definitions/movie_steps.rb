# Add a declarative step here for populating the DB with movies.

movies_count = 0
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
    movies_count += 1
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  is_match = /#{e1}.*#{e2}/m =~ page.body
  assert !is_match.nil?
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

#All movies means our count is equal to the number inserted into the db.
Then /I should see (all|no) movies/ do |flag|
  movies = page.find('#movies')
  rows = movies.all('tr').length
  expected = (flag == 'no') ? 0 : 11
  assert expected == rows
end

#By director
Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |title, director|
  m = Movie.find_by_title(title)
  m.director.should == director
end 

When /I (un)?check the following ratings: (.*)/ do |is_unchecked, rating_list|
  rating_list.delete!("\"")
  rating_list.split(',').each { |r|
    ratings_str = "ratings[" + r.strip + "]"
    if !is_unchecked.nil?
      uncheck(ratings_str)
    else
      check(ratings_str)
    end
  }
end
