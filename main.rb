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
            

    def simulate_game()
      computer_choice = randomize()
    #   puts computer_choice
      
      while @@win_condition == false && @@turn_counter < 11
        for i in 1..4 do
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
            break
        else
            puts "\nUnfortunately your selection did not match the codemaker. Please try again!"
            puts "\n"
            @@turn_counter += 1
            @choice_array = []
        end
      end
    end
end

test = GameBoard.new()
test.simulate_game
