RSpec.describe Codenjoy::Client::Games::Icancode do
  before(:context) do
    @msg_from_server = File.open("spec/games/icancode/test_board.json", "r").read
    @board = Codenjoy::Client::Games::Icancode::Board.new
    @board.process(@msg_from_server)

    p @board.get_walls[4]
  end

  it { expect(@board.get_other_heroes).to eq [[1.0, 6.0], [1.0, 5.0], [6.0, 6.0], [2.0, 2.0], [6.0, 4.0]] }
  it { expect(@board.get_gold).to eq [[3.0, 7.0], [5.0, 6.0], [2.0, 5.0]] }
  it { expect(@board.get_starts).to eq [[1.0, 7.0]] }
  it { expect(@board.get_exits).to eq [[3.0, 5.0]] }
  it { expect(@board.get_boxes).to eq [[5.0, 5.0], [3.0, 4.0], [6.0, 4.0], [5.0, 3.0]] }
  it { expect(@board.get_holes).to eq [[7.0, 7.0], [6.0, 6.0], [4.0, 4.0], [2.0, 3.0]] }
  it { expect(@board.get_laser_machines).to eq [[4.0, 1.0], [1.0, 4.0], [3.0, 2.0], [3.0, 1.0], [4.0, 7.0], [6.0, 1.0], [7.0, 1.0], [5.0, 1.0]] }
  it { expect(@board.get_lasers).to eq [[6.0, 2.0], [2.0, 4.0], [5.0, 2.0], [5.0, 4.0]] }
  it { expect(@board.get_zombies).to eq [[3.0, 3.0], [1.0, 3.0], [2.0, 3.0], [4.0, 3.0]] }
  it { expect(@board.get_walls.size).to eq 32 }
  it { expect(@board.wall_at?(4, 8)).to eq true }
  it { expect(@board.wall_at?(5, 9)).to eq false }
end
