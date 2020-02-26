RSpec.describe Codenjoy::Client::Games::Tetris do
  before(:context) do
    @msg_from_server = File.open("spec/games/tetris/test_board.json", "r").read
    @board = Codenjoy::Client::Games::Tetris::Board.new
    @board.process(@msg_from_server)
    puts @board.to_s
  end

  it { expect(@board.current_figure_type).to eq "T" }
  it { expect(@board.current_figure_point.to_s).to eq "[1,2]" }
  it { expect(@board.future_figures).to eq ["I", "O", "L", "Z"] }

  context "test pt1" do
    before(:context) { @pt1 = Point.new(0, 0) }
    it { expect(@board.get_at(@pt1)).to eq ELEMENTS[:NONE] }
    it { expect(@board.is_at?(@pt1, ELEMENTS[:O_YELLOW])).to eq false }
    it { expect(@board.is_at?(@pt1, ELEMENTS[:NONE])).to eq true }
    it { expect(@board.is_at?(@pt1, [ELEMENTS[:L_ORANGE], ELEMENTS[:NONE]])).to eq true }
    it { expect(@board.is_free?(@pt1)).to eq true }
  end

  context "test pt2" do
    before(:context) { @pt2 = Point.new(2, 0) }
    it { expect(@board.get_at(@pt2)).to eq ELEMENTS[:O_YELLOW] }
    it { expect(@board.is_at?(@pt2, ELEMENTS[:O_YELLOW])).to eq true }
    it { expect(@board.is_at?(@pt2, ELEMENTS[:NONE])).to eq false }
    it { expect(@board.is_at?(@pt2, [ELEMENTS[:L_ORANGE], ELEMENTS[:NONE]])).to eq false }
    it { expect(@board.is_free?(@pt2)).to eq false }
  end

  context "test pt3" do
    before(:context) { @pt3 = Point.new(2, 2) }
    it { expect(@board.get_at(@pt3)).to eq ELEMENTS[:S_GREEN] }
    it { expect(@board.is_at?(@pt3, ELEMENTS[:O_YELLOW])).to eq false }
    it { expect(@board.is_at?(@pt3, ELEMENTS[:NONE])).to eq false }
    it { expect(@board.is_at?(@pt3, [ELEMENTS[:L_ORANGE], ELEMENTS[:NONE]])).to eq false }
    it { expect(@board.is_free?(@pt3)).to eq false }
  end

  context "test pt4" do
    before(:context) { @pt4 = Point.new(3, 4) }
    it { expect(@board.get_at(@pt4)).to eq ELEMENTS[:L_ORANGE] }
    it { expect(@board.is_at?(@pt4, ELEMENTS[:O_YELLOW])).to eq false }
    it { expect(@board.is_at?(@pt4, ELEMENTS[:NONE])).to eq false }
    it { expect(@board.is_at?(@pt4, [ELEMENTS[:L_ORANGE], ELEMENTS[:NONE]])).to eq true }
    it { expect(@board.is_free?(@pt4)).to eq false }

    it { expect(@board.get_near(@pt4).to_s).to eq '[".", "L", ".", "L", ".", "I", ".", "."]' }
    it { expect(@board.is_near?(@pt4, ELEMENTS[:T_PURPLE])).to eq false }
    it { expect(@board.is_near?(@pt4, ELEMENTS[:I_BLUE])).to eq true }
    it { expect(@board.count_near(@pt4, ELEMENTS[:I_BLUE])).to eq 1 }
    it { expect(@board.count_near(@pt4, ELEMENTS[:L_ORANGE])).to eq 2 }
  end

  context "test pt5" do
    before(:context) { @pt5 = Point.new(3, 4) }
    # it { expect(@board.get_at(@pt4)).to eq ELEMENTS[:L_ORANGE] }
    # it { expect(@board.is_at?(@pt4, ELEMENTS[:O_YELLOW])).to eq false }
    # it { expect(@board.is_at?(@pt4, ELEMENTS[:NONE])).to eq false }
    # it { expect(@board.is_at?(@pt4, [ELEMENTS[:L_ORANGE], ELEMENTS[:NONE]])).to eq true }
    # it { expect(@board.is_free?(@pt4)).to eq false }
  end
pt5 = Point.new(3, 4)

# pt3 = Point.new(2, 2)
end
