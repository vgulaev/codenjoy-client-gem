require "bundler/setup"
require "codenjoy/client"
require "codenjoy/games/battlecity/board"
require "codenjoy/games/expansion/board"
require "codenjoy/games/icancode/board"
require "codenjoy/games/clifford/board"
require "codenjoy/games/snake/board"
require "codenjoy/games/snakebattle/board"
require "codenjoy/games/tetris/board"
require "codenjoy/games/minesweeper/board"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
