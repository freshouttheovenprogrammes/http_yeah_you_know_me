class Game
  attr_reader :answer,
              :guess_count,
              :recent_guess

  def initialize
    @answer = [*1..100].sample(1)
    @guess_count = 0
    @recent_guess = recent_guess
  end

  def start_game
    "Good luck!"
  end

  def guess(user_guess)
    @recent_guess = user_guess
  end

  def check(user_guess)
    @guess_count += 1
    if guess(user_guess) > answer[0] # < must be a better way then just using [0]
      "Too low!"
    elsif guess(user_guess) < answer[0] # < must be a better way then just using [0]
      "Too high!"
    else
      "Correct!"
    end
  end

end
