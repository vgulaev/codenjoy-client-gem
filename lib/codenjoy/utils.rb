class Point
  attr_accessor :x
  attr_accessor :y

  # Coords (1,1) - upper left side of field
  #
  # @param [Integer] x X coord
  # @param [Integer] y Y coord
  def initialize(x, y)
    @x = x
    @y = y
  end

  # Override of compare method for Point
  def == (other_object)
    other_object.x == @x && other_object.y == @y
  end

  # For better +.inspect+ output
  def to_s
    "[#{@x},#{@y}]"
  end

  # Position of point above current
  def up
    Point.new(@x, @y + 1)
  end

  # Position of point below current
  def down
    Point.new(@x, @y - 1)
  end

  # Position of point on the left side
  def left
    Point.new(@x - 1, @y)
  end

  # Position of point on the right side
  def right
    Point.new(@x + 1, @y)
  end

  def out_of?(board_size)
    x >= board_size || y >= board_size || x < 0 || y < 0;
  end
end

class LengthToXY
  def initialize(board_size)
    @board_size = board_size
  end

  def inversionY(y)
    @board_size - 1 - y;
  end

  def inversionX(x)
    x;
  end

  def getXY(length)
    return nil if (length == -1)
    x = inversionX(length % @board_size);
    y = inversionY((length / @board_size).floor);
    return Point.new(x, y);
  end

  def getLength(x, y)
      xx = inversionX(x);
      yy = inversionY(y);
      yy * @board_size + xx;
  end
end
