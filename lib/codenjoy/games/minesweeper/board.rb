require "codenjoy/utils"
require "codenjoy/base_board"

module Codenjoy
  module Client
    module Games
      module Minesweeper
      end
    end
  end
end

class Codenjoy::Client::Games::Minesweeper::Board < BaseBoard
  ELEMENTS = {
    BANG: 'Ѡ',
    HERE_IS_BOMB: '☻',
    DETECTOR: '☺',
    FLAG: '‼',
    HIDDEN: '*',

    ONE_MINE: '1',
    TWO_MINES: '2',
    THREE_MINES: '3',
    FOUR_MINES: '4',
    FIVE_MINES: '5',
    SIX_MINES: '6',
    SEVEN_MINES: '7',
    EIGHT_MINES: '8',

    BORDER: '☼',
    NONE:' ',
    DESTROYED_BOMB: 'x'
  }

  def process(str)
    puts "-------------------------------------------------------------------------------------------"
    puts str
    @raw = str
  end

  def get_me
    find_by_list([:DETECTOR].map{ |e| ELEMENTS[e] })
  end

  def get_boarders
    find_by_list([:BORDER].map{ |e| ELEMENTS[e] })
  end

  def flag_cell(direction)
    "FLAG, #{direction}"
  end

  def  to_s
    [
      "Board:",
      board_to_s
    ].join("\n")
  end
end
