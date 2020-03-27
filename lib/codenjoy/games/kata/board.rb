require "codenjoy/utils"
require "codenjoy/base_board"

module Codenjoy
  module Client
    module Games
      module Kata
      end
    end
  end
end

class Codenjoy::Client::Games::Kata::Board < BaseBoard
  attr_accessor :data

  def process(data, level)
    @data = JSON.parse(data)
  end
end
