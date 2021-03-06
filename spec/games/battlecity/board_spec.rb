RSpec.describe Codenjoy::Client::Games::Battlecity do
  before(:context) do
    @formated_data = File.open("spec/games/battlecity/test_board.txt", "r").read
    @board = Codenjoy::Client::Games::Battlecity::Board.new
    data = @formated_data.split("\n").join('')
    @board.process(data)
  end

  let(:enemies) do
    [
      [12.0, 4.0], [2.0, 32.0], [28.0, 32.0],
      [29.0, 32.0], [1.0, 18.0], [31.0, 31.0],
      [10.0, 19.0], [28.0, 17.0], [2.0, 4.0]
    ]
  end

  it { expect(@board.board_to_s + "\n").to eq @formated_data }
  it { expect(@board.get_me).to eq [9.0, 5.0] }
  it { expect(@board.get_bullets).to eq [[28.0, 20.0], [12.0, 1.0]] }
  it { expect(@board.bullet_at?(28, 20)).to eq true }
  it { expect(@board.game_over?).to eq false }
  it { expect(@board.near?(4, 4, Codenjoy::Client::Games::Battlecity::Board::ELEMENTS[:CONSTRUCTION])).to eq true }
  it { expect(@board.near?(100, 100, Codenjoy::Client::Games::Battlecity::Board::ELEMENTS[:CONSTRUCTION])).to eq false }
  it { expect(@board.get_barriers.size).to eq 547 }
  it { expect(@board.any_of_at?(9, 5, Codenjoy::Client::Games::Battlecity::Board::TANK)).to eq true }
  it { expect(@board.barrier_at?(28, 13)).to eq true }
  it { expect(@board.count_near(4, 4, "╬")).to eq 5 }
  it { expect(@board.get_near(4,4)).to eq ["╨", "└", "╬", "╬", "╬", "╬", "╬", "╩"] }
  it { expect(@board.count_near(4, 4, "╬")).to eq 5 }
  it { expect(@board.get_enemies).to eq enemies }

  context "shoud correct for outborded coord" do
    %w(get_at bullet_at? any_of_at?).each do |method|
      it { expect(@board.send(method, 100, 100)).to eq false }
    end
  end
end
