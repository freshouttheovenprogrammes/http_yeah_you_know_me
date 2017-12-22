require_relative 'test_helper'
require './lib/game'

class GameTest < Minitest::Test

  def test_that_it_exists
    game = Game.new

    assert_instance_of Game, game
  end

  def test_start_game_response
    game = Game.new

    assert_equal "Good luck!", game.start_game
  end

  def test_answer_has_only_one_number
    game = Game.new
    game.start_game
    assert_equal 1, game.answer.count
  end

  def test_recent_guess_is_accurate
    game = Game.new
    game.start_game
    game.guess(88)
    game.check(88)
    game.guess(67)
    game.check(67)

    assert_equal 67, game.recent_guess
  end

  def test_recent_guess_count_is_accurate
    game = Game.new
    game.start_game
    game.guess(88)
    game.check(88)
    game.guess(67)
    game.check(67)

    assert_equal 2, game.guess_count
  end

  def test_recent_guess_response_is_accurate
    game = Game.new
    game.answer << 95

    game.guess(77)

    assert_equal "too low!", game.check(77)

    game.guess(99)

    assert_equal "too high!", game.check(99)

    game.guess(95)

    assert_equal "correct", game.check(95)
  end

  def test_game_diagnostics
    game = Game.new
    game.answer << 5

    game.guess(88)
    game.check(88)
    game.guess(8)
    game.check(8)
    game.guess(55)
    game.check(55)

    assert_equal "You have taken 3 guesses and your most recent guess was 55", game.game_diagnostics
  end
end
