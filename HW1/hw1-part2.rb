#Andrew Hawker
#SaaS - Armando Fox & David Patterson (Spring 2012)
#Assignment 1 - Part 2
#http://spark-university.s3.amazonaws.com/berkeley-saas/homework/hw1.pdf

class WrongNumberOfPlayersError < StandardError; end
class NoSuchStrategyError < StandardError; end

#(2a)
#Write a method that takes a two-element list and returns the name and strategy on the winner as a list.
# - If the number of players is not equal to 2, raise WrongNumberOfPlayersError.
# - If either player's strategy is not Rock, Paper or Scissors, raise NoSuchStrategyError.
def rps_game_winner(game)
  raise WrongNumberOfPlayersError unless game.length == 2

  p1 = Player.new(game[0])
  p2 = Player.new(game[1])

  (p1.beats(p2) || p1.ties(p2)) ? game[0] : game[1]
end

#(2b)
#A rock, paper, scissors tournament is encoded as a bracketed array of games.
#Process the tournament and return the winner.
def rps_tournament_winner(game)
  if game.length == 2 && game[0][0].is_a?(String)
    return rps_game_winner(game)
  else
     rps_tournament_winner([rps_tournament_winner(game[0]), rps_tournament_winner(game[1])]) 
  end
end

class Player
  attr_accessor :name, :strategy

  def initialize(player)
    @name, @strategy = validate(player)
  end

  def validate(player)
    raise NoSuchStrategyError unless player.length == 2

    name = player[0]
    strategy = player[1].downcase
    strategies = ['p', 'r', 's']

    raise NoSuchStrategyError unless strategy.to_s != ''
    raise NoSuchStrategyError unless strategy.to_s.strip.length != 0
    raise NoSuchStrategyError unless strategies.include?(strategy)

    return name, strategies.index(strategy)
  end

  def beats(enemy)
    ((self.strategy+1) % 3) == enemy.strategy
  end

  def ties(enemy)
    self.strategy == enemy.strategy
  end
end
