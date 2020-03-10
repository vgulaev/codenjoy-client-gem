###
# #%L
# Codenjoy - it's a dojo-like platform from developers to developers.
# %%
# Copyright (C) 2018 Codenjoy
# %%
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public
# License along with this program.  If not, see
# <http://www.gnu.org/licenses/gpl-3.0.html>.
# #L%
###

require "codenjoy/utils"
require "codenjoy/base_board"

module Codenjoy
  module Client
    module Games
      module Loderunner
      end
    end
  end
end

class Codenjoy::Client::Games::Loderunner::Board < BaseBoard

  ELEMENTS = {
    # a void
    NONE: ' ',

    # walls
    BRICK: '#',
    PIT_FILL_1: '1',
    PIT_FILL_2: '2',
    PIT_FILL_3: '3',
    PIT_FILL_4: '4',
    UNDESTROYABLE_WALL: '☼',

    DRILL_PIT: '*',

    # this is enemy
    ENEMY_LADDER: 'Q',
    ENEMY_LEFT: '«',
    ENEMY_RIGHT: '»',
    ENEMY_PIPE_LEFT: '<',
    ENEMY_PIPE_RIGHT: '>',
    ENEMY_PIT: 'X',

    # gold ;)
    GOLD: '$',

    # this is you
    HERO_DIE: 'Ѡ',
    HERO_DRILL_LEFT: 'Я',
    HERO_DRILL_RIGHT: 'R',
    HERO_LADDER: 'Y',
    HERO_LEFT: '◄',
    HERO_RIGHT: '►',
    HERO_FALL_LEFT: ']',
    HERO_FALL_RIGHT: '[',
    HERO_PIPE_LEFT: '{',
    HERO_PIPE_RIGHT: '}',

    # this is other players
    OTHER_HERO_DIE: 'Z',
    OTHER_HERO_LEFT: ')',
    OTHER_HERO_RIGHT: '(',
    OTHER_HERO_LADDER: 'U',
    OTHER_HERO_PIPE_LEFT: 'Э',
    OTHER_HERO_PIPE_RIGHT: 'Є',

    # ladder and pipe - you can walk
    LADDER: 'H',
    PIPE: '~'
  };

  HERO = [
    :HERO_DIE, :HERO_DRILL_LEFT, :HERO_DRILL_RIGHT,
    :HERO_FALL_RIGHT, :HERO_FALL_LEFT, :HERO_LADDER,
    :HERO_LEFT, :HERO_RIGHT, :HERO_PIPE_LEFT, :HERO_PIPE_RIGHT
  ]

  OTHER_HERO = [
    :OTHER_HERO_LEFT, :OTHER_HERO_RIGHT, :OTHER_HERO_LADDER, :OTHER_HERO_PIPE_LEFT, :OTHER_HERO_PIPE_RIGHT
  ]

  ENEMY = [
    :ENEMY_LADDER, :ENEMY_LADDER, :ENEMY_LEFT, :ENEMY_PIPE_LEFT, :ENEMY_PIPE_RIGHT, :ENEMY_RIGHT, :ENEMY_PIT
  ]

  PIPE = [
    :PIPE, :HERO_PIPE_LEFT, :HERO_PIPE_RIGHT, :OTHER_HERO_PIPE_LEFT, :OTHER_HERO_PIPE_RIGHT
  ]

  def process(data)
    @raw = data
  end

  def to_s
    [
      "Board:",
      board_to_s,
      "Me at: #{get_me}",
      "Other heroes at: #{get_other_heroes}",
      "Enemies at: #{get_enemies}",
      "Gold at: #{get_gold}"
    ].join("\n")
  end

  def get_me
    find_by_list(HERO.map{ |e| ELEMENTS[e] })
  end

  def get_other_heroes
    find_by_list(OTHER_HERO.map{ |e| ELEMENTS[e] })
  end

  def get_enemies
    find_by_list(ENEMY.map{ |e| ELEMENTS[e] })
  end

  def get_gold
    find_by_list([ELEMENTS[:GOLD]])
  end

  def get_walls
    find_by_list([ELEMENTS[:BRICK], ELEMENTS[:UNDESTROYABLE_WALL]])
  end

  def get_ladders
    find_by_list([ELEMENTS[:LADDER], ELEMENTS[:HERO_LADDER], ELEMENTS[:ENEMY_LADDER]])
  end

  def get_pipes
    find_by_list(PIPE.map{ |e| ELEMENTS[e] })
  end

  def game_over?
    !@raw.index(ELEMENTS[:HERO_DIE]).nil?
  end

  def get_barriers
    [get_enemies, get_other_heroes, get_walls].flatten(1)
  end

  def barrier_at?(x, y)
    return false if Point.new(x, y).out_of?(size)
    !get_barriers.index([x, y]).nil?
  end

  def enemy_at?(x, y)
    return false if Point.new(x, y).out_of?(size)
    any_of_at?(x, y, ENEMY.map{ |e| ELEMENTS[e] })
  end

  def other_hero_at?(x, y)
    return false if Point.new(x, y).out_of?(size)
    any_of_at?(x, y, OTHER_HERO.map{ |e| ELEMENTS[e] })
  end

  def wall_at?(x, y)
    return false if Point.new(x, y).out_of?(size)
    any_of_at?(x, y, [ELEMENTS[:BRICK], ELEMENTS[:UNDESTROYABLE_WALL]])
  end

  def ladder_at?(x, y)
    return false if Point.new(x, y).out_of?(size)
    any_of_at?(x, y, [ELEMENTS[:LADDER], ELEMENTS[:HERO_LADDER], ELEMENTS[:ENEMY_LADDER]])
  end

  def gold_at?(x, y)
    return false if Point.new(x, y).out_of?(size)
    at?(x, y, ELEMENTS[:GOLD])
  end

  def pipe_at?(x, y)
    return false if Point.new(x, y).out_of?(size)
    any_of_at?(x, y, PIPE.map{ |e| ELEMENTS[e] })
  end
end
