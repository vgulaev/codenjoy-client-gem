RSpec.describe Codenjoy::Client::Games::Clifford do
  before(:context) do
    @formated_data = File.open("spec/games/clifford/test_board.txt", "r").read
    @board = Codenjoy::Client::Games::Clifford::Board.new
    data = @formated_data.split("\n").join('')
    @board.process(data)
    p @board.get_pipes[4]
  end

  it { expect(@board.board_to_s + "\n").to eq @formated_data }
  it { expect(@board.get_me).to eq [[48.0, 25.0]] }
  it { expect(@board.get_other_heroes).to eq [[49.0, 25.0]] }
  it { expect(@board.get_enemies).to eq [[37.0, 22.0], [37.0, 22.0], [35.0, 22.0], [38.0, 22.0], [39.0, 22.0]] }
  it { expect(@board.get_gold.size).to eq 115 }
  it { expect(@board.get_walls.size).to eq 1186 }
  it { expect(@board.get_ladders.size).to eq 285 }
  it { expect(@board.get_pipes.size).to eq 226 }
  it { expect(@board.game_over?).to eq false }
  it { expect(@board.get_barriers.size).to eq 1192 }
  it { expect(@board.barrier_at?(0, 0)).to eq true }
  it { expect(@board.barrier_at?(3, 3)).to eq false }
  it { expect(@board.enemy_at?(37, 22)).to eq true }
  it { expect(@board.enemy_at?(36, 22)).to eq false }
  it { expect(@board.other_hero_at?(49, 25)).to eq true }
  it { expect(@board.other_hero_at?(50, 25)).to eq false }
  it { expect(@board.wall_at?(6, 55)).to eq true }
  it { expect(@board.wall_at?(7, 54)).to eq false }
  it { expect(@board.ladder_at?(1, 3)).to eq true }
  it { expect(@board.ladder_at?(2, 3)).to eq false }
  it { expect(@board.gold_at?(14, 52)).to eq true }
  it { expect(@board.gold_at?(16, 52)).to eq false }
  it { expect(@board.pipe_at?(34, 56)).to eq true }
  it { expect(@board.pipe_at?(34, 50)).to eq false }
end
