require "./known_board"

class HumanPlayer < KnownBoard
  def get_move : Square
    x, y = STDIN.gets.split()
    Square,new(x.to_i, y.to_i)
  end
end
