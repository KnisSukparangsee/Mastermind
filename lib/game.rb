require 'rainbow/refinement'
using Rainbow

class Game
  def initialize
    @@COLORS = {
      'red' => 'FF0000',
      'blue' => '0000FF',
      'yellow' => 'FFFF00',
      'orange' => 'FFA500',
      'purple' => '800080',
      'green' => '00FF00',
      'white' => 'FFFFFF',
      'black' => '000000'
    }
    valid_colors = @@COLORS.keys[0..5]
    @code = valid_colors.sample(4)
    @turns = 12
    @guesses = []
    @hint = []
  end

  def play
    loop do
      user_input
      if guess_correct?
        puts 'You win!'
        break
      elsif @turns.zero?
        puts 'You lose!'
        break
      end
      generate_hint
      next_round
    end
  end

  def user_input
    i = 0
    while i < 4
      print "Enter color ##{i + 1}: "
      guess_color = gets.chomp.downcase
      @guesses.push(guess_color)
      i += 1
    end
    display_guesses
  end

  def generate_hint
    @guesses.each_with_index do |element, index|
      if @code[index] == element
        @hint.push(@@COLORS['red'])
      elsif @code.include?(element)
        @hint.push(@@COLORS['white'])
      else
        @hint.push(@@COLORS['black'])
      end
    end

    display_hint
  end

  def guess_correct?
    @guesses == @code
  end

  def display_guesses
    print 'Your guess: '
    @guesses.each do |color|
      index = @@COLORS.fetch(color, 'invalid')
      hex = index == 'invalid' ? @@COLORS['black'] : @@COLORS[color]
      print Rainbow('O').color(hex)
    end
    puts
  end

  def display_hint
    print 'Hint: '
    @hint.each do |hex|
      print Rainbow('O').color(hex)
    end
  end

  def next_round
    @guesses.clear
    @hint.clear
    @turns -= 1
  end
end
