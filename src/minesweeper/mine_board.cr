require "./board"

class MineBoard < Board(Int32)
  MINE  = -1
  EMPTY = 0

  def initialize(width, height, no_of_mines)
    super(width, height, EMPTY)
    generate(no_of_mines)
    calculate_counts
  end

  def mine?(x, y)
    get(x, y) == MINE
  end

  def mine?(square)
    get(square) == MINE
  end

  def generate(no_of_mines)
    while no_of_mines > 0
      x, y = rand(@width), rand(@height)
      unless self.mine?(x, y)
        set(x, y, MINE)
        no_of_mines -= 1
      end
    end
  end

  def calculate_counts
    each.each do |square, item|
      adjacencies(square).each do |square2|
       set(square2, get(square2) + 1) unless mine?(square2)
      end
    end
  end

  def to_s(x, y)
    m = get(x, y)
    m == MINE ? '*' : (m == 0 ? '.' : m.to_s)
  end
end
