require "codenjoy/utils"

module Codenjoy
  module Client
    module Games
      module Snake
      end
    end
  end
end

class Codenjoy::Client::Games::Snake::Board
  ELEMENTS = {
    BAD_APPLE: '☻',
    GOOD_APPLE: '☺',

    BREAK: '☼',

    HEAD_DOWN: '▼',
    HEAD_LEFT: '◄',
    HEAD_RIGHT: '►',
    HEAD_UP: '▲',

    TAIL_END_DOWN: '╙',
    TAIL_END_LEFT: '╘',
    TAIL_END_UP: '╓',
    TAIL_END_RIGHT: '╕',
    TAIL_HORIZONTAL: '═',
    TAIL_VERTICAL: '║',
    TAIL_LEFT_DOWN: '╗',
    TAIL_LEFT_UP: '╝',
    TAIL_RIGHT_DOWN: '╔',
    TAIL_RIGHT_UP: '╚',

    NONE: ' '
  }

  def xyl
    @xyl ||= LengthToXY.new(size);
  end

  def size
    @size ||= Math.sqrt(@raw.length);
  end

  def process(str)
    puts "-------------------------------------------------------------------------------------------"
    puts str
    @raw = str
  end

  def board_to_s
    Array.new(size).each_with_index.map{ |e, n| @raw[(n * size)..((n + 1) * size - 1)]}.join("\n")
  end

  def getAt(x, y)
    return false if Point.new(x, y).out_of?(size)
    @raw[xyl.getLength(x, y)];
  end

  def at?(x, y, element)
    return false if Point.new(x, y).out_of?(size)
    getAt(x, y) == element;
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

  def get_my_head
    find_by_list([:HEAD_DOWN, :HEAD_UP, :HEAD_RIGHT, :HEAD_LEFT].map{ |e| ELEMENTS[e] })
  end

  def get_my_body
    find_by_list([
      :HEAD_DOWN, :HEAD_LEFT, :HEAD_RIGHT, :HEAD_UP,
      :TAIL_END_DOWN, :TAIL_END_LEFT, :TAIL_END_UP,
      :TAIL_END_RIGHT, :TAIL_HORIZONTAL, :TAIL_VERTICAL,
      :TAIL_LEFT_DOWN, :TAIL_LEFT_UP, :TAIL_RIGHT_DOWN, :TAIL_RIGHT_UP
    ].map{ |e| ELEMENTS[e] })
  end

  def get_apple
    find_by_list([ELEMENTS[:GOOD_APPLE]])
  end

  def get_stone
    find_by_list([ELEMENTS[:BAD_APPLE]])
  end

  def get_walls
    find_by_list([ELEMENTS[:BREAK]])
  end

  def get_barriers
    find_by_list([ELEMENTS[:BREAK], ELEMENTS[:BAD_APPLE]])
  end

  def barrier_at?(x, y)
    return false if Point.new(x, y).out_of?(size)
    get_barriers.include?([x.to_f, y.to_f]);
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

  def count_near(x, y, element)
    return 0 if Point.new(x, y).out_of?(size)
    count = 0
    count += 1 if at?(x - 1, y    , element)
    count += 1 if at?(x + 1, y    , element)
    count += 1 if at?(x    , y - 1, element)
    count += 1 if at?(x    , y + 1, element)
    return count;
  end

  def to_s
    [
      "Board: \n#{board_to_s}",
      "My head at: #{get_my_head}",
      "My body at: #{get_my_body}",
      "Apple at: #{get_apple}",
      "Stone at: #{get_stone}"
    ].join("\n")
  end
end
