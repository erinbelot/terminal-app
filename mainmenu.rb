require_relative 'scoreboard'
require 'artii'
# START OF PROGRAM
# *** Highest level menu ***
# User picks teacher or student mode
def start_menu high_scores_array
    menu_answer = 0
    
    until menu_answer == "x"
        system 'clear'
        system "artii 'Select Mode :'"
        print """
            [s] - Student mode
            [t] - Teacher mode

            [x] - Exit program
            
            Input: """
        menu_answer = gets.chomp.downcase
        
        if menu_answer == "s" 
            student_menu high_scores_array
        elsif menu_answer == "t" 
            teacher_menu high_scores_array
        elsif menu_answer == "x"
            break
        else
            puts "Not a valid input. Try again."
            sleep 1.5
        end
    end
end

# STUDENT MODE PROGRAM
# Student mode basic functions:
# 1. Choose the category to play hangman with
# 2. Play hangman 
# 3. Views the high scores
# 4. Exits student mode
def student_menu high_scores_array
    student_answer = 0

    until student_answer == "4" 
        system 'clear'
        system "artii 'HANGMAN'"
        system "artii 'EDUMACATOR'"
        print student_menu = """
        Student Menu:
        1. Choose list 
        2. Play 
        3. Leaderboard 
        4. Exit
        
        Input: """  
        student_answer = gets.chomp

        if student_answer == "1" 
            puts "1 is the response"
        elsif student_answer == "2" 
            start_new_game high_scores_array
        elsif student_answer == "3" 
            score_board_exit = 0
            until score_board_exit == "b"
                system 'clear'
                high_scores_array = []
                print_as_table read_scoreboard_file high_scores_array
                print "\n\nEnter 'b' to go back: "
                score_board_exit = gets.chomp.downcase
                if score_board_exit != "b"
                    system 'clear'
                    puts "Invalid input. Try again."
                    sleep 1
                else
                    break
                end
            end 
        elsif student_answer == "4"
            break
        else
            puts "Not a valid input. Try again."
            sleep 1.5
        end 

    end
end


# TEACHER MODE PROGRAM
# Teacher mode advanced functions:
# 1. Import / Create new lists for hangman game
# 2. Play hangman 
# 3. Views high scores in a performance-over-time graph
# 4. Exits teacher mode
def teacher_menu high_scores_array
    teacher_answer = 0
    until teacher_answer == "4"
        system 'clear'
        system 'artii "HANGMAN"'
        system 'artii "EDUMACATOR"'
        print """
        Teacher Menu
        1. Import/Create list
        2. Play
        3. Timeline/improvement graph
        4. Exit
        Input: """
  
        teacher_answer = gets.chomp

        if teacher_answer == "1" 
            puts "go to import_list"
        elsif teacher_answer == "2" 
            start_new_game high_scores_array
        elsif teacher_answer == "3" 
            score_board_exit = 0
            until score_board_exit == "b"
                system 'clear'
                high_scores_array = []
                print_as_table read_scoreboard_file high_scores_array
                print "\n\nEnter 'b' to go back: "
                score_board_exit = gets.chomp.downcase
                if score_board_exit != "b"
                    system 'clear'
                    puts "Invalid input. Try again."
                    sleep 1
                else
                    break
                end
            end 
        elsif teacher_answer == "4"
            break
        else
            puts "Not a valid input. Try again."
            sleep 1.5
        end 
        
    end       
end

