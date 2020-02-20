# require_relative "codenjoy/client"
require "bundler/setup"
require "codenjoy/client"

game = Codenjoy::Client::Game.new

url = "https://dojorena.io/codenjoy-contest/board/player/70xewv6o7ddy9yphm1u0?code=2603484461919438773&gameName=battlecity"
count = 0

game.play(url, 'debug') do |ws, msg|
  p msg
  ws.send('Up')
  p count
  count += 1
end
