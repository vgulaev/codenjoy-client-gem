RSpec.describe Codenjoy::Client::Games::Icancode do
  before(:context) do
    @msg_from_server = File.open("spec/games/icancode/test_board.json", "r").read
    @board = Codenjoy::Client::Games::Icancode::Board.new
    @board.process(@msg_from_server)
  end

  it { expect(true).to eq true }
end
