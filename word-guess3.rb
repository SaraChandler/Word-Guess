class Picture

  def initialize
    @wrong_answers = 0
    @hangman = ['''
  +---+
  |   |
      |
      |
      |
      |
=========''', '''
  +---+
  |   |
  O   |
      |
      |
      |
=========''', '''
  +---+
  |   |
  O   |
  |   |
      |
      |
=========''', '''
  +---+
  |   |
  O   |
 /|   |
      |
      |
=========''', '''
  +---+
  |   |
  O   |
 /|\  |
      |
      |
=========''', '''
  +---+
  |   |
  O   |
 /|\  |
 /    |
      |
=========''', '''
  +---+
  |   |
  O   |
 /|\  |
 / \  |
      |
=========''']

  end

  def add_piece
    @wrong_answers += 1
  end

  def put_pic
    return @hangman[@wrong_answers]
  end

  def out_of_pieces?
    if @wrong_answers == @hangman.length - 1
      return true
    else
      return false
    end
  end

end

class Word

  def initialize(a_word)
    @a_word = a_word.split(//)
    @word_state = []
    (@a_word.length).times do
      @word_state << "_"
    end
  end

  def put_word_state
    return @word_state.join(" ")
  end

  def guess_check(guess)
    if guess.length == 1
      if @a_word.include?(guess)
        i = 0
        @a_word.each do |letter|
          if letter == guess
            @word_state[i] = guess
          end
          i += 1
        end
        return true
      else
        return false
      end
    else
        if @a_word.join == guess
          @word_state = @a_word
          return true
        else
          return false
        end
    end
  end

  def solved?
    if @word_state.include?("_")
      return false
    else
      return true
    end
  end
end

class Game

def initialize(word_bank)
  @a_word = word_bank.sample
  @new_picture = Picture.new
  @new_word = Word.new(@a_word)
  @guess_list = []
end

def display_game_state
  puts @new_picture.put_pic
  puts @new_word.put_word_state
  puts "Letters guessed: #{@guess_list.join(" ")}"
end

def get_guess
  puts "Guess a letter, or solve the puzzle: "
  @guess = gets.chomp.downcase
  if @guess_list.include?(@guess)
    puts "You've already guessed that."
    @guess = self.get_guess
  else
    self.add_guess_list(@guess)
  end
  return @guess
end

def add_guess_list(guess)
  @guess_list << guess
  return @guess_list
end


def run_game
  while true
    if @new_picture.out_of_pieces?
      puts @new_picture.put_pic
      puts "You've lost the game!"
      return @a_word
    elsif @new_word.solved?
      puts "You've won the game!"
      return @a_word
    else
      self.display_game_state
      if @new_word.guess_check(self.get_guess) == false
        @new_picture.add_piece
      end

    end
  end
end
end

def welcome
  puts "Welcome to word guess!"
  puts
  puts "Please pick a difficulty: easy, medium, or hard"
  difficulty = gets.chomp.downcase
  return difficulty
end

def endgame
  puts "Would you like to play again? y for yes, n for no."
  play_again = gets.chomp.downcase
  if play_again == "y"
    return true
  else
    return false
  end
end

easy = ["cat", "dog", "rat", "bat", "sow"]
medium = ["four", "five", "frog", "deer", "love"]
hard = ["loser", "awful", "wreck", "smell", "moose"]

while true
  start = welcome
   if start == "easy"
     if easy.length == 0
       puts "You've tried all the puzzles. Pick another"
       puts "difficulty."
       next
     end
     new_game = Game.new(easy)
     used_word = new_game.run_game
     easy.delete(used_word)
   elsif start == "medium"
     if medium.length == 0
       puts "You've tried all the puzzles. Pick another"
       puts "difficulty."
       next
     end
     new_game = Game.new(medium)
     used_word = new_game.run_game
     medium.delete(used_word)
   else
     if hard.length == 0
       puts "You've tried all the puzzles. Pick another"
       puts "difficulty."
       next
     end
     new_game = Game.new(hard)
     used_word = new_game.run_game
     hard.delete(used_word)
   end
   if endgame == false
     break
   end
end
