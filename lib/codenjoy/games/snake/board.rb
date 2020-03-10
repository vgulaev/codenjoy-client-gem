require "codenjoy/utils"
require "codenjoy/base_board"

module Codenjoy
  module Client
    module Games
      module Snake
      end
    end
  end
end

class Codenjoy::Client::Games::Snake::Board < BaseBoard
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

  def process(str)
    puts "-------------------------------------------------------------------------------------------"
    puts str
    @raw = str
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

  def to_s
    [
      "Board:",
      board_to_s,
      "My head at: #{get_my_head}",
      "My body at: #{get_my_body}",
      "Apple at: #{get_apple}",
      "Stone at: #{get_stone}"
    ].join("\n")
  end
end
