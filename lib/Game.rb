require 'rainbow/refinement'
using Rainbow

class Game
  def initialize
    @@COLORS = ['red', 'blue', 'yellow', 'orange', 'purple', 'green']
    @@HEX =  ['FF0000', '0000FF', 'FFFF00', 'FFA500', '800080', '00FF00']
    @code = @@COLORS.sample(4)
    @turns = 12
    @guesses = []
    @hint = []
  end

  def play
    loop do
      puts @@COLORS
      @@HEX.each do |hex|
        puts Rainbow('O').color(hex)
      end
      puts @code
      i = 0
      while i < 4
        print "Enter color ##{i + 1}: "
        guess_color = gets.chomp.downcase
        @guesses.push(guess_color)
        i += 1
      end

      display_guesses

      if guess_correct?
        puts "You win!"
        break
      end

      @guesses.each_with_index do |element, index| 
        if @code[index] == element
          @hint.push("red")
        elsif @code.include?(element)
          @hint.push('000000')
        else
          @hint.push("none")
        end
      end

      display_hint

      @hint.clear

      @guess.clear
    end
  end

  def guess_correct?
    @guess == @code
  end

  def display_guesses
    print "Your guesses: #{@guess}"
  end

  def display_hint
    @hint.each do |color|
      print Rainbow('O').color(":#{color}")
    end
  end
end
