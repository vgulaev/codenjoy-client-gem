RSpec.describe Codenjoy::Client::Games::Loderunner do
  before(:context) do
    @formated_data = File.open("spec/games/loderunner/test_board.txt", "r").read
    @board = Codenjoy::Client::Games::Loderunner::Board.new
    data = @formated_data.split("\n").join('')
    @board.process(data)
  end
end
