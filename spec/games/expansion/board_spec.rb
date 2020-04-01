RSpec.describe Codenjoy::Client::Games::Expansion::Board do
  before(:context) do
    @formated_data = File.open("spec/games/expansion/test_board.json", "r").read
    @board = Codenjoy::Client::Games::Expansion::Board.new
    data = @formated_data.split("\n").join('')
    @board.process(data)
    @elements = Codenjoy::Client::Games::Expansion::Board::ELEMENTS
    p @board.get_holes
  end

  it { expect(@board.get_gold).to eq [[9.0, 10.0], [10.0, 10.0], [9.0, 9.0], [10.0, 9.0]] }
  it { expect(@board.get_bases).to eq [[2.0, 17.0], [17.0, 17.0], [17.0, 2.0], [2.0, 2.0]] }
  it { expect(@board.get_exits).to eq [] }
  it { expect(@board.get_breaks.size).to eq 16 }
  it { expect(@board.get_holes).to eq 16 }

end
