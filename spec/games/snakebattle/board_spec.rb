RSpec.describe Codenjoy::Client::Games::Snakebattle::Board do
  before(:context) do
    @formated_data = File.open("spec/games/snakebattle/test_board.txt", "r").read
    @board = Codenjoy::Client::Games::Snakebattle::Board.new
    data = @formated_data.split("\n").join('')
    @board.process(data)
    @elements = Codenjoy::Client::Games::Snakebattle::Board::ELEMENTS
  end

  it { expect(@board.get_walls.size).to eq 169 }
  it { expect(@board.get_enemy.size).to eq 9 }
  it { expect(@board.get_apple.size).to eq 17 }
  it { expect(@board.get_my_head).to eq [[11.0, 27.0]] }
  it { expect(@board.get_my_body).to eq [[11.0, 27.0], [10.0, 27.0]] }
  it { expect(@board.get_stone).to eq [[13.0, 24.0], [26.0, 19.0], [6.0, 16.0], [18.0, 11.0]] }
end
