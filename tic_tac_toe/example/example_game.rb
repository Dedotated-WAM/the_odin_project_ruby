require_relative "../lib/tic_tac_toe"

puts "Welcome to tic tac toe"
puts "Enter Player One's name:"
player_one_name = gets.chomp
player_one_color = nil
loop do
  puts "Will you be 'X' or 'O' ?"
  color = gets.chomp.upcase
  if %w[X O].include?(color)
    player_one_color = color
    break
  else
    puts "Invalid entry."
  end
end

puts "Enter Player Two's name:"
player_two_name = gets.chomp
player_two_color = player_one_color == "X" ? "O" : "X"

@player1 = TicTacToe::Player.new({ color: player_one_color,
                                   name: player_one_name })
@player2 = TicTacToe::Player.new({ color: player_two_color,
                                   name: player_two_name })

players = [@player1, @player2]
TicTacToe::Game.new(players).play
