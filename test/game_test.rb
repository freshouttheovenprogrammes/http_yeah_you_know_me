require_relative 'test_helper'
require './lib/game'

class GameTest < Minitest::Test

  def test_that_it_exists
    game = Game.new

    assert_instance_of Game, game
  end

  def test_answer_has_only_one_number
    game = Game.new

    assert_equal 1, game.answer.count
  end

  def test_recent_guess_is_accurate
    game = Game.new
    game.guess(88)
    game.check(88)
    game.guess(67)
    game.check(67)

    assert_equal 67, game.recent_guess
  end

  def test_recent_guess_count_is_accurate
    game = Game.new
    game.guess(88)
    game.check(88)
    game.guess(67)
    game.check(67)

    assert_equal 2, game.guess_count
  end

end
