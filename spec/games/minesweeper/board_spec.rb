RSpec.describe Codenjoy::Client::Games::Minesweeper do
  before(:context) do
    @formated_data = File.open("spec/games/minesweeper/test_board.txt", "r").read
    @board = Codenjoy::Client::Games::Minesweeper::Board.new
    data = @formated_data.split("\n").join('')
    @board.process(data)
  end

  it { expect(@board.board_to_s + "\n").to eq @formated_data }
  it { expect(@board.get_me).to eq [[1.0, 1.0]] }
  it { expect(@board.get_boarders.first).to eq [0.0, 14.0] }
  it { expect(@board.flag_cell('RIGHT')).to eq "FLAG, RIGHT" }
end
