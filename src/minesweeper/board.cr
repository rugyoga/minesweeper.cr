require "./types"

class Board(A)
  @width   : Col
  @height  : Row
  @default : A
  @board   : Hash(Square, A)

  def initialize(width, height, default)
    @width, @height, @default = width, height, default
    @board = Hash(Square, A).new(@default)
  end

  def set(square : Square, item : A)
    @board[square] = item
  end

  def set(col : Col, row : Row, item : A)
    @board[Square.new(row, col)] = item
  end

  def get(square : Square)
    @board[square]
  end

  def get(col : Col, row : Row)
    get(Square.new(col, row))
  end

  def legal?(col : Col, row : Row)
    0 <= col && col < @width &&
    0 <= row && row < @height
  end

  def legal?(square : Square)
    legal?(square[0], square[1])
  end

  def adjacencies(col : Col, row : Row)
    left,  right = col-1, col+1
    above, below = row-1, row+1
    [{left, above}, {col, above}, {right, above},
     {left, row},                 {right, row},
     {left, below}, {col, below}, {right, below}]
     .select{ |square| legal?(square) }
  end

  def adjacencies(square : Square)
    adjacencies(square[0], square[1])
  end

  def adjacent_match(square : Square, item : A)
    adjacencies(square).select{ |x, y| get(x, y) == item }
  end

  def adjacent_match(col : Col, row : Row, item : A)
    adjacencies(Square.new(col, row), item)
  end

  def adjacent?(col1 : Col, row1 : Row, col2 : Col, row2 : Row)
    (row1 - row2).abs < 2 &&
    (col1 - col2).abs < 2 &&
    !(row1 == row2 && col1 == col2)
  end

  def adjacent?(square1 : Square, square2 : Square)
    adjacent?(square1[0], square1[1], square2[0], square2[1])
  end

  def each(&block)
    @board.each do |item|
      yield item
    end
  end

  def each
    results = [] of Tuple(Square,A)
    each{ |xyz| results << xyz }
    results
  end
end
