
require_relative 'word_list'
require_relative 'mainmenu'
require_relative 'scoreboard'

high_scores_array = []
# Method that takes in array of characters and outputs guesses to generated array of blanks
# 
# randomized_word_array : array of characters from generated random word
# display_word_array : blank array of characters to display to user 
#                      correct guesses will be pushed into this array at the corresponding position
#
# if guess is incorrect, outputs invalid message and pushes error into tried_chars array
#
# if guess has already been made, outputs invalid message

def user_guess_letter guess, randomized_word_array, display_word_array, tries, tried_chars
    if randomized_word_array.include? guess
        print_at_index = randomized_word_array.each_index.select do |char| 
        randomized_word_array[char] == guess 
        end
        print_at_index.each do |index| 
        display_word_array[index] = guess
        end
    elsif tried_chars.include? guess
        system 'clear'
        puts """


            You have already guessed '#{guess}'. Try again."""
        system 'say -v Fred You already tried that'
        sleep 1
    else
        system 'clear'
        puts """
        
        
        '#{guess}' is not in the word."""
        system 'say -v Trinoids WRONG'
        tried_chars << guess
        tries -= 1
        sleep 1
    end
    return tries ## Matt's quick-fix:: Suggestion to call tries from hash
    return tried_chars 
end

# Animation for loading sequence between game rounds
def loading_sequence round
    counter = 2
    until counter == 0
        system 'clear'
        puts """
        +================================+
        |           New Game             |
        |           ROUND: #{round}             |
        |  Generating new word..         |
        +================================+"""
        sleep 0.3
        system 'clear'
        puts """
    +========================================+
    |               New Game                 |
    |               ROUND: #{round}                 |
    |      Generating new word....           |
    +========================================+"""            
        sleep 0.3
        system'clear'
        puts """
        +================================+
        |           New Game             |
        |           ROUND: #{round}             |
        |  Generating new word......     |
        +================================+"""            
        sleep 0.3
        system 'clear'
        puts """
    +========================================+
    |               New Game                 |
    |               ROUND: #{round}                 |
    |      Generating new word........       |
    +========================================+"""      
        sleep 0.3
        system 'clear'
        puts """
        +================================+
        |           New Game             |
        |           ROUND: #{round}             |
        |  Generating new word.......... |
        +================================+"""
        sleep 0.3    
        system 'clear'
        puts """
    +========================================+
    |               New Game                 |
    |               ROUND: #{round}                 |
    |      Generating new word............   |
    +========================================+"""      
        sleep 0.3

        counter -= 1
    end
end

# Hangman Game Interface
def hangman_game score_name, score, round
    until round > 5

        loading_sequence round

        tries = 6
        tried_chars = []

        randomized_word_array = randomize_list(Word_list).split('')
        display_word_array = [].fill('_', 0, randomized_word_array.count)

        until display_word_array.join == randomized_word_array.join
            system 'clear'
            print """
            ROUND: #{round}
            #{score_name}'s: #{score}


            #{display_word_array.join(" ")}

            You have #{tries} tries remaining.

            Tried guesses:
            #{tried_chars}
            Enter your guess: """
            guess = gets.downcase.chomp
            tries = user_guess_letter guess, randomized_word_array, display_word_array, tries, tried_chars
            if display_word_array.join == randomized_word_array.join
                score += tries
                round += 1
                system 'clear'
                puts """
            +===================================+
            |                                   |
            | Winner, Winner, Chicken, Dinner!! |
            |                                   |
            +===================================+
                    
                    The word was #{randomized_word_array.join}
                    Your score is #{score}"""  
                system 'say -v good win win win win win'
                sleep 2               
            elsif tries == 0
                round += 1
                system 'clear'
                puts """
            +===================================+
            |                                   |
            |       LooooOOOOOoOOooseeeer!!     |
            |                                   |
            +===================================+
                    
                    The word was #{randomized_word_array.join.upcase}
                    Your score is #{score}"""  
                system 'say -v hysterical hahaha you suck'
                sleep 2
                break
            end
        end
        
    end
    system 'clear'
    finalscore_line1 = "#{score_name}, your final score is:"
    finalscore_line2 = "#{score}"
    puts """
            +====================================+
            |                                    |
    #{finalscore_line1.center(55)}    
            |                                    |
    #{finalscore_line2.center(55)}                    
            |                                    |
            +====================================+
    """
    system 'say -v Lee Whatever your score, you are a winner to me.'
    sleep 3
    return score
end

def start_new_game high_scores_array
    score = 0
    round = 1

    system 'clear'
    print """
                #{'*' * 35}

                 Welcome to the Hangman Edumacator

                #{'*' * 35}

                What is your name?: """
    score_name = gets.chomp

    # game_result_array = hangman_game score_name, score, round
    # high_scores_array << {name: game_result_array[0], score: game_result_array[1]}
    score = hangman_game score_name, score, round
    
    write_scoreboard_file high_scores_array, score_name, score

    system 'clear'
    high_scores_array = []
    print_as_table read_scoreboard_file high_scores_array
    sleep 4
end

start_menu high_scores_array