require "./known_board"

class ComputerPlayer < KnownBoard
  @corners:   Array(Square)
  @mines:     Int32
  @dimension: Int32


  def initialize(dimension, mines)
    super(dimension, dimension)
    @dimension     = dimension
    max            = dimension-1
    @corners       = [Square.new(0,0), Square.new(0, max), Square.new(max, 0), Square.new(max, max)].shuffle
    @mines         = mines
    @moves         = [] of Square
    @safes         = [] of Square
    @bombs         = [] of Square
  end

  def random_square : Square
    Square.new(rand(@width), rand(@height))
  end

  def random_move : Square
    square = random_square
    until unknown?(square)
      square = random_square
    end
    square
  end

  def add_bombs(bombs)
    bombs.each do |square|
      if unknown?(square)
        flag!(square)
        @bombs.push(square)
      end
    end
  end

  def add_safes(squares)
    @safes.concat( squares ).uniq!
  end

  def all_unknowns_are_bombs(square)
    count = get(square)
    unknowns = adjacent_match(square, UNKNOWN)
    bombs = adjacent_match(square, FLAGGED)
    add_bombs( unknowns ) if !unknowns.empty? && count == bombs.size + unknowns.size
  end

  def all_unknowns_are_safes(square)
    count = get(square)
    unknowns = adjacent_match(square, UNKNOWN)
    bombs = adjacent_match(square, FLAGGED)
    add_safes( unknowns ) if !unknowns.empty? && count == bombs.size
  end

  def set(square, c)
    super(square, c)
    return if c == EXPLODED
    all_unknowns_are_bombs(square)
    all_unknowns_are_safes(square)
  end

  def check_all_counts
    sorted = each.select{ |square, count| count >= 0 }.sort_by{ |square, count| count }
    sorted.each do |square, count|
      unknowns = adjacent_match(square, UNKNOWN)
      next if unknowns.empty?
      bombs    = adjacent_match(square, FLAGGED)
      add_bombs( unknowns ) if count == bombs.size + unknowns.size
      add_safes( unknowns ) if count == bombs.size
    end
  end

  def get_move : Square
    check_all_counts if @safes.empty?
    unless @safes.empty?
      @safes.pop
    else
      corners = @corners.select{ |square| unknown?(square) }
      unless corners.empty?
        corners.pop
      else
        random_move
      end
    end.tap do |m|
      @moves << m
    end
  end
end
