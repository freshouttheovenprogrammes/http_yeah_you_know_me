class Game
  attr_reader :answer,
              :guess_count,
              :recent_guess

  def initialize
    @answer = []
    @guess_count = 0
    @recent_guess = recent_guess
  end

  def start_game
    answer_generator
    "Good luck!"
  end

  def answer_generator
    @answer = [*1..100].sample(1)
  end

  def guess(user_guess)
    @recent_guess = user_guess
  end

  def game_diagnostics
    "You have taken #{guess_count} guesses and your most recent guess was #{recent_guess}"
  end

  def check(user_guess)
    @guess_count += 1
    if guess(user_guess) == answer[0]
      return "correct"
    elsif guess(user_guess) < answer[0]
      "too low!"
    elsif guess(user_guess) > answer[0]
      "too high!"
    else
      recent_guess.nil?
      return "nothing here..."
    end
  end
end
