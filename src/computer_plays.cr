#!/usr/bin/env crystal
require "./minesweeper/computer_player"
require "./minesweeper/minesweeper"

if ARGV.size < 2
  puts "usage: ./human_plays <dimension> <number of mines>"
  exit(1)
end
dimension = ARGV[0].to_i
mines     = ARGV[1].to_i
minesweeper = Minesweeper.new(dimension, mines, ComputerPlayer.new(dimension, mines))
minesweeper.run()
