# require_relative "codenjoy/client"
require "bundler/setup"
require "codenjoy/client"
require "codenjoy/games/battlecity/board"

class YourSolver
  # UP:   'up',                // you can move
  # DOWN: 'down',
  # LEFT: 'left',
  # RIGHT:'right',
  # ACT:  'act',               // fire
  # STOP: ''                   // stay
  def get_answer(board)

    #######################################################################
    #
    #                     YOUR ALGORITHM HERE
    #
    #######################################################################

    return 'act'
  end

end

game = Codenjoy::Client::Game.new
# board = Codenjoy::Client::Games::Battlecity::Board.new
board = Codenjoy::Client::Games::Tetris::Board.new

url = "https://dojorena.io/codenjoy-contest/board/player/70xewv6o7ddy9yphm1u0?code=2603484461919438773&gameName=battlecity"
count = 0


game.play(url) do |ws, msg|
  json = msg[6..-1].force_encoding('UTF-8')
  board.process(json)
  puts board.to_s

  ws.send('Up')
  p count
  count += 1
end
