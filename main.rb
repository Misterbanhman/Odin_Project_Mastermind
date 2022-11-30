require 'colorize'

class GameBoard
    @@blue =  "  ".colorize(background: :blue)
    @@red =  "  ".colorize(background: :red)
    @@yellow =  "  ".colorize(background: :yellow)
    @@green =  "  ".colorize(background: :green)
    @@magenta = "  ".colorize(background: :magenta)
    @@cyan = "  ".colorize(background: :cyan)
    @@win_condition = false
    @@turn_counter = 1
    
    def initialize()
      @choice_array = []
    end

    def board_display(player, hints)
        puts "HINTS: #{hints[0]} #{hints[1]} #{hints[2]} #{hints[3]} | BOARD: #{player[0]} #{player[1]} #{player[2]} #{player[3]}"
    end
    
    def randomize()
      random_colors = [@@blue, @@red, @@yellow, @@green, @@magenta, @@cyan]
      return random_colors = random_colors.shuffle.take(4)
    end

    def check_valid_move(choice)
      colors = ["r", "b", "y", "g", "c", "m"]

      if colors.include?(choice) == true && @choice_array.any?(choice) == false
        @choice_array.append(choice)

      else
        puts "The value you've chosen is not one of the colors or already chosen. Please try again." 
        puts "You must select 'r', 'g', 'b', 'c', 'm' or 'y' !"
        new_choice = gets.chomp
        check_valid_move(new_choice)
      end
    end

    def convert_to_color(array)
      converted_array = []
      array.each do |x|
        if x == 'b'
          converted_array.append(@@blue)

        elsif x == 'g'
          converted_array.append(@@green)

        elsif x == 'y'
          converted_array.append(@@yellow)
        
        elsif x == 'm'
            converted_array.append(@@magenta)
        
        elsif x == 'c'
            converted_array.append(@@cyan)

        else
          converted_array.append(@@red)
        end
      end

      return converted_array
    end

    def compare(computer_choice, player_choice)
      hints_array = []
      comparison_array = []

      for i in 0..3 do
        if computer_choice[i] == player_choice[i]
            hints_array.append("○")
        else
            comparison_array.append(player_choice[i])
        end
      end

      computer_choice.each do |x|
        if comparison_array.include?(x)
            hints_array.append("●")
        end
      end

      return hints_array.shuffle

    end

    def check_win(hints)
      correct_counter = 0

      hints.each do |x|
        if x == "○"
            correct_counter += 1
        else
            correct_counter += 0
        end
      end

      if correct_counter == 4
        @@win_condition = true
        return true
      
      else
        return false
      end

    end
            
    #Simulates game with computer as Codemaker and human as Codebreaker
    def simulate_game_1()
      computer_choice = randomize()
    #   puts computer_choice
      
      while @@win_condition == false && @@turn_counter < 10
        for i in 1..4 do
            puts "--------------ROUND #{@@turn_counter}--------------"
            puts "Please enter a color choice you'd like for position " + i.to_s 
            puts "--------------------------------\n"
            choice = gets.chomp
            puts "\n"
            check_valid_move(choice)
        end

        converted_player_choice = convert_to_color(@choice_array)
        hints = compare(computer_choice, converted_player_choice)
        board_display(converted_player_choice, hints)

        if check_win(hints) == true
            puts "--------------------------------------------"
            puts "You have won the game on ROUND #{@@turn_counter}! Congratulations!"
            exit 1
        else
            puts "\nUnfortunately your selection did not match the codemaker. Please try again!"
            puts "\n"
            @@turn_counter += 1
            @choice_array = []
        end
      end
      puts "You were not able to decipher the code in #{@@turn_counter} ROUNDS!!"
    end

    def simulate_game_2()
        puts "You are the Codemaker! Please choose different colors to fill all four positions."
        for i in 1..4 do
            puts "Please enter a color choice you'd like for position " + i.to_s 
            puts "--------------------------------\n"
            choice = gets.chomp
            puts "\n"
            check_valid_move(choice)
        end

        converted_player_choice = convert_to_color(@choice_array)

        puts "You've created the board: \n--------------------------------"
        puts board_display(converted_player_choice,[])
        puts "--------------------------------"

        puts "\nThe computer will now try and guess your code."

        while @@win_condition == false && @@turn_counter < 11
            computer_choice = randomize()
            hints = compare(converted_player_choice, computer_choice)
            puts "\n--------------ROUND #{@@turn_counter}--------------"
            puts "\n"
            board_display(computer_choice, hints)
            @@turn_counter += 1

            if check_win(hints) == true
                puts "\n The computer has deciphered your code on ROUND #{@@turn_counter}!".colorize(color: :green)
                exit 1
            end
        end
        puts "\nThe computer was UNABLE to decipher your code. You win!".colorize(color: :red)
    end
end

test = GameBoard.new()
puts "Please choose a game mode. Please enter '1' to be CodeMaker or '2' to be the CodeBreaker."
choice = gets.chomp

if choice.to_i == 1
    test.simulate_game_2
elsif choice.to_i == 2
    test.simulate_game_1
else
    "The value you entered was neither '1' nor '2'."
end
