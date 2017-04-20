#!/usr/bin/env ruby
require "./known_board"
require "./mine_board"

class Minesweeper
  @dimension : Int32
  @mines     : Int32
  @player    : KnownBoard

  def initialize(dimension, mines, player)
    @dimension   = dimension
    @mines       = mines
    @player      = player
    @state       = :running
    @mine_board  = MineBoard.new(dimension, dimension, mines)
    @move_number = 1
  end

  def to_s(square : Square)
    @state == :won && !@player.known?(square) ? '*' : @player.to_s(square)
  end

  def display
    @dimension.times do |y|
      puts @dimension.times.map{ |x| to_s(Square.new(x, y)) }.join
    end
  end

  def play_move(square : Square)
    @move_number += 1
    @player.set(square, @mine_board.get(square))
    @mine_board.mine?(square)
  end

  def check_win
    @dimension * @dimension == @move_number - 1 + @mines
  end

  def run(show=true)
    while @state == :running
      display if show
      m = @player.get_move()
      puts "##{@move_number}: #{m[0]},#{m[1]}" if show
      if play_move(m)
        puts "Mine exploded!" if show
        @state = :lost
      elsif check_win
        puts "All mines found!" if show
        @state = :won
      end
    end
    display if show
    @state == :won
  end
end
