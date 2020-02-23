RSpec.describe Codenjoy::Client::Games::Battlecity do
  before(:context) do
    @formated_data = File.open("spec/games/battlecity/test_board.txt", "r").read
    @board = Codenjoy::Client::Games::Battlecity::Board.new
    data = @formated_data.split("\n").join('')
    @board.process(data)
  end

  it { expect(@formated_data).to eq(@board.board_to_s + "\n") }
  it { expect([9.0, 5.0]).to eq @board.get_me }
end
