
require 'terminal-table'

high_scores_array = []

def read_scoreboard_file high_scores_array
    file = File.open('scoreboard.csv', 'r')

    file.each_line do |line|
        field = line.split(',')
        high_scores_array << {name: field[0], score: field[1].chomp}  
    end
    file.close
    return  high_scores_array
end

def write_scoreboard_file high_scores_array, score_name, score
    File.open('scoreboard.csv', 'a+') do |line|
        line << "#{score_name},#{score}\n"
    end
end

def print_as_table high_scores_array

    my_rows = []
    my_heading = ['Name', 'Score']

    high_scores_array.each do |player|
        my_rows << [player[:name], player[:score]]
    end

    table = Terminal::Table.new :headings => my_heading, :rows => my_rows
    puts table

end


# working on sorting by highest to lowest

# player_array.sort_by do |hash| 
#     hash[key] }.each do
#     |score|
#         puts my_hash[key]
#     end
# end

# end of working on highest to lowest