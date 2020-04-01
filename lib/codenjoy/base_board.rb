require "codenjoy/utils"

class BaseBoard
  def xyl
    @xyl ||= LengthToXY.new(size);
  end

  def size
    @size ||= Math.sqrt(@raw.length);
  end

  def board_to_s
    Array.new(size).each_with_index.map{ |e, n| @raw[(n * size)..((n + 1) * size - 1)]}.join("\n")
  end

  def get_at(x, y)
    return false if Point.new(x, y).out_of?(size)
    @raw[xyl.getLength(x, y)]
  end

  def any_of_at?(x, y, elements = [])
    return false if Point.new(x, y).out_of?(size)
    elements.each do |e|
      return true if at?(x, y, e)
    end
    false;
  end

  def near?(x, y, element)
    return false if Point.new(x, y).out_of?(size)
    at?(x + 1, y, element) || at?(x - 1, y, element) || at?(x, y + 1, element) || at?(x, y - 1, element)
  end

  def at?(x, y, element)
    return false if Point.new(x, y).out_of?(size)
    get_at(x, y) == element;
  end

  def find_all(element)
    result = []
    @raw.length.times do |i|
      point = xyl.getXY(i);
      result.push(point) if at?(point.x, point.y, element)
    end
    result;
  end

  def find_by_list(list)
    list.map{ |e| find_all(e) }.flatten.map{ |e| [e.x, e.y] }
  end

  def count_near(x, y, element)
    return 0 if Point.new(x, y).out_of?(size)
    count = 0
    count += 1 if at?(x - 1, y    , element)
    count += 1 if at?(x + 1, y    , element)
    count += 1 if at?(x    , y - 1, element)
    count += 1 if at?(x    , y + 1, element)
    count
  end
end

class Layer < BaseBoard
  def initialize(data)
    @raw = data
  end
end
