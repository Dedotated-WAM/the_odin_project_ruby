require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'hangman/board'
require_relative 'hangman/game'
require_relative 'hangman/version'
require 'yaml'
Minitest::Reporters.use!

module Hangman
  attr_accessor :game

  def self.save_game(game)
    Dir.chdir('saves/') do
      puts 'Enter a name for save game file:'
      file_name = gets.chomp
      File.open("#{file_name}.yml", 'w') { |file| file.write(game.to_yaml) }
      puts "Game saved to #{file_name}.  Goodbye."
      exit!
    end
  end

  def self.load_game
    Dir.chdir('saves/') do
      puts Dir.glob('*.yml')
      puts 'Enter the name of the file to load:'
      file_name = gets.chomp
      file_name = "#{file_name}.yml" unless file_name.match?(/\.yml/)
      puts file_name
      if File.exist?(file_name)
        puts 'file exists'
        File.open(file_name) do |f|
          @game = YAML.load(f)
          puts @game
          @game.play_game
        end
      else
        puts 'Error. File not found.'
        puts "Try again ('y' or 'n')?"
        response = gets.chomp.downcase
        load_game if response == 'y'
      end
    end
  end
end
