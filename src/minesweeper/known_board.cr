require "./board"

class KnownBoard < Board(Int32)
  UNKNOWN  = -3
  FLAGGED  = -2
  EXPLODED = -1

  def initialize(width, height)
    super(width, height, UNKNOWN)
  end

  def known?(square)
    get(square) != UNKNOWN
  end

  def unknown?(square)
    get(square) == UNKNOWN
  end

  def flag!(square)
    set(square, FLAGGED)
  end

  def flagged?(square)
    get(square) == FLAGGED
  end

  def to_s(square)
    c = get(square)
    case c
    when UNKNOWN  then '_'
    when FLAGGED  then 'F'
    when EXPLODED then 'X'
    when 0        then '.'
    else c.to_s
    end
  end

  def get_move
    raise "UnimplementedMethod"
  end
end
