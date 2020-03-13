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
      module Icancode
      end
    end
  end
end

class Layer < BaseBoard
  def initialize(data)
    @raw = data
  end
end

class Codenjoy::Client::Games::Icancode::Board < BaseBoard

  ELEMENT = {
    EMPTY: '-',
    FLOOR: '.',

    ANGLE_IN_LEFT: '╔',
    WALL_FRONT: '═',
    ANGLE_IN_RIGHT: '┐',
    WALL_RIGHT: '│',
    ANGLE_BACK_RIGHT: '┘',
    WALL_BACK: '─',
    ANGLE_BACK_LEFT: '└',
    WALL_LEFT: '║',
    WALL_BACK_ANGLE_LEFT: '┌',
    WALL_BACK_ANGLE_RIGHT: '╗',
    ANGLE_OUT_RIGHT: '╝',
    ANGLE_OUT_LEFT: '╚',
    SPACE: ' ',

    LASER_MACHINE_CHARGING_LEFT: '˂',
    LASER_MACHINE_CHARGING_RIGHT: '˃',
    LASER_MACHINE_CHARGING_UP: '˄',
    LASER_MACHINE_CHARGING_DOWN: '˅',

    LASER_MACHINE_READY_LEFT: '◄',
    LASER_MACHINE_READY_RIGHT: '►',
    LASER_MACHINE_READY_UP: '▲',
    LASER_MACHINE_READY_DOWN: '▼',

    START: 'S',
    EXIT: 'E',
    HOLE: 'O',
    BOX: 'B',
    ZOMBIE_START: 'Z',
    GOLD: '$',

    ROBOT: '☺',
    ROBOT_FALLING: 'o',
    ROBOT_FLYING: '*',
    ROBOT_LASER: '☻',

    ROBOT_OTHER: 'X',
    ROBOT_OTHER_FALLING: 'x',
    ROBOT_OTHER_FLYING: '^',
    ROBOT_OTHER_LASER: '&',

    LASER_LEFT: '←',
    LASER_RIGHT: '→',
    LASER_UP: '↑',
    LASER_DOWN: '↓',

    FEMALE_ZOMBIE: '♀',
    MALE_ZOMBIE: '♂',
    ZOMBIE_DIE: '✝'
  }

  attr_accessor :l1, :l2, :l3 # short names for layers

  def command
    # 'up'                // you can move
    # 'down'
    # 'left'
    # 'right'
    # 'act(1)'            // jump
    # 'act(2)'            // pull box
    # 'act(3)'            // fire
    # 'act(0)'            // die
  end

  def process(data)
    @data = JSON.parse(data)
    @raw = @data["layers"][0]
    @l1 = Layer.new(@data["layers"][0])
    @l2 = Layer.new(@data["layers"][1])
    @l3 = Layer.new(@data["layers"][2])
  end

  def nline(i)
    return " 0" if 0 == i
    format("%02.0d", i)
  end

  def numberinline(length)
    Array.new(length) { |i| (i % 10).to_s }.join
  end

  def headfoot
    Array.new(3).map{ |i| "  " + numberinline(size) }.join
  end

  def headlayers
    spaces = ([' '] * (size - 6)).join()
    @data["layers"].each_with_index.map{ |e, n| " Layers#{n + 1}#{spaces}" }.join('')
  end

  def get_me
    [@data['heroPosition']['x'], @data['heroPosition']['y']]
  end

  def get_other_heroes
    l2.find_by_list([ELEMENT[:ROBOT_OTHER], ELEMENT[:ROBOT_OTHER_FALLING], ELEMENT[:ROBOT_OTHER_LASER]])
#         var elements = [Element.ROBOT_OTHER, Element.ROBOT_OTHER_FALLING, Element.ROBOT_OTHER_LASER];
#         return get(LAYER2, elements)
#             .concat(get(LAYER3, Element.ROBOT_OTHER_FLYING));
  end

  def infoline(n)
    res = [
      " Robots: #{get_me}, #{get_other_heroes}", # (getOtherHeroes());
      " Gold: ", # + printArray(getGold());
      " Starts: ", # + printArray(getStarts());
      " Exits: ", # + printArray(getExits());
      " Boxes: ", # + printArray(getBoxes());
      " Holes: ", # + printArray(getHoles());
      " LaserMachine: ", # + printArray(getLaserMachines());
      " Lasers: ", # + printArray(getLasers());
      " Zombies: " # + printArray(getZombies());    ]
    ]
    d = 1
    return res[n - d] if d <= n && n < res.size + d
    ""
  end

  def board_to_s
    ([headlayers, headfoot] +
    Array.new(size).each_with_index.map do |e, n|
      @data["layers"].map{ |l| nline(size - n - 1) + l[(n * size)..((n + 1) * size - 1)] }.join + infoline(n)
    end + [headfoot]).join("\n")
  end

  def to_s
    # p @data
    board_to_s
  end
end
# var Board = function (board) {
#     var layersString = board.layers;
#     var scannerOffset = board.offset;
#     var heroPosition = board.heroPosition;
#     var levelFinished = board.levelFinished;
#     var size = Math.sqrt(layersString[LAYER1].length);
#     var xyl = new LengthToXY(size);

#     var parseLayer = function (layer) {
#         var map = [];
#         for (var x = 0; x < size; x++) {
#             map[x] = [];
#             for (var y = 0; y < size; y++) {
#                 map[x][y] = Element.getElement(layer.charAt(xyl.getLength(x, y)))
#             }
#         }
#         return map;
#     }

#     var layers = [];
#     for (var index in layersString) {
#         layers.push(parseLayer(layersString[index]));
#     }

#     // TODO to add List<Elements> getNear(int numLayer, int x, int y) method

#     var isAt = function (layer, x, y, elements) {
#         if (!Array.isArray(elements)) {
#             var arr = [];
#             arr.push(elements);
#             elements = arr;
#         }

#         if (pt(x, y).isBad(size) || getAt(layer, x, y) == null) {
#             return false;
#         }

#         for (var e in elements) {
#             var element = elements[e];
#             if (getAt(layer, x, y).char == element.char) {
#                 return true;
#             }
#         }
#         return false;
#     };

#     var getAt = function (layer, x, y) {
#         return layers[layer][x][y];
#     };

#     var removeAllElements = function(array, element) {
#         var index;
#         while ((index = array.indexOf(element)) !== -1) {
#             array.splice(index, 1);
#         }
#         return array;
#     }

#     var getWholeBoard = function() {
#         var result = [];
#         for (var x = 0; x < size; x++) {
#             var arr = [];
#             result.push(arr);
#             for (var y = 0; y < size; y++) {
#                 var cell = [];
#                 cell.push(getAt(LAYER1, x, y).type);
#                 cell.push(getAt(LAYER2, x, y).type);
#                 cell.push(getAt(LAYER3, x, y).type);
#                 removeAllElements(cell, 'NONE');
#                 if (cell.length == 0) {
#                     cell.push('NONE');
#                 }

#                 arr.push(cell);
#             }
#         }
#         return result;
#     }

#     var get = function (layer, elements) {
#         if (!Array.isArray(elements)) {
#             var arr = [];
#             arr.push(elements);
#             elements = arr;
#         }
#         var result = [];
#         for (var x = 0; x < size; x++) {
#             for (var y = 0; y < size; y++) {
#                 for (var e in elements) {
#                     var element = elements[e];
#                     if (isAt(layer, x, y, element)) {
#                         result.push(element.direction ? new Point(x, y, element.direction.toString()) : new Point(x, y));
#                     }
#                 }
#             }
#         }
#         return result;
#     };

#     var isNear = function (layer, x, y, element) {
#         if (pt(x, y).isBad(size)) {
#             return false;
#         }
#         return isAt(layer, x + 1, y, element) || isAt(layer, x - 1, y, element)
#             || isAt(layer, x, y + 1, element) || isAt(layer, x, y - 1, element);
#     };

#     var isBarrierAt = function (x, y) {
#         if (!barriersMap) {
#             getBarriers();
#         }
#         return barriersMap[x][y];
#     };

#     var isWallAt = function (x, y) {
#         return getAt(LAYER1, x, y).type == 'WALL';
#     };

#     var countNear = function (layer, x, y, element) {
#         if (pt(x, y).isBad(size)) {
#             return 0;
#         }
#         var count = 0;
#         if (isAt(layer, x + 1, y, element)) count++;
#         if (isAt(layer, x - 1, y, element)) count++;
#         if (isAt(layer, x, y - 1, element)) count++;
#         if (isAt(layer, x, y + 1, element)) count++;
#         return count;
#     };

#     var getOtherHeroes = function () {
#         var elements = [Element.ROBOT_OTHER, Element.ROBOT_OTHER_FALLING, Element.ROBOT_OTHER_LASER];
#         return get(LAYER2, elements)
#             .concat(get(LAYER3, Element.ROBOT_OTHER_FLYING));
#     };

#     var getLaserMachines = function () {
#         var elements = [Element.LASER_MACHINE_CHARGING_LEFT, Element.LASER_MACHINE_CHARGING_RIGHT,
#             Element.LASER_MACHINE_CHARGING_UP, Element.LASER_MACHINE_CHARGING_DOWN,
#             Element.LASER_MACHINE_READY_LEFT, Element.LASER_MACHINE_READY_RIGHT,
#             Element.LASER_MACHINE_READY_UP, Element.LASER_MACHINE_READY_DOWN];
#         return get(LAYER1, elements);
#     };

#     var getLasers = function () {
#         var elements = [Element.LASER_LEFT, Element.LASER_RIGHT,
#             Element.LASER_UP, Element.LASER_DOWN];
#         return get(LAYER2, elements);
#     };

#     var getWalls = function () {
#         var elements = [Element.ANGLE_IN_LEFT, Element.WALL_FRONT,
#             Element.ANGLE_IN_RIGHT, Element.WALL_RIGHT,
#             Element.ANGLE_BACK_RIGHT, Element.WALL_BACK,
#             Element.ANGLE_BACK_LEFT, Element.WALL_LEFT,
#             Element.WALL_BACK_ANGLE_LEFT, Element.WALL_BACK_ANGLE_RIGHT,
#             Element.ANGLE_OUT_RIGHT, Element.ANGLE_OUT_LEFT,
#             Element.SPACE];
#         return get(LAYER1, elements);
#     };

#     var getBoxes = function () {
#         return get(LAYER2, Element.BOX);
#     };

#     var getStarts = function () {
#         return get(LAYER1, Element.START);
#     };

#     var getZombieStart = function () {
#         return get(LAYER1, Element.ZOMBIE_START);
#     };

#     var getExits = function () {
#         return get(LAYER1, Element.EXIT);
#     };

#     var getGold = function () {
#         return get(LAYER1, Element.GOLD);
#     };

#     var getZombies = function () {
#         var elements = [Element.FEMALE_ZOMBIE, Element.MALE_ZOMBIE,
#                     Element.ZOMBIE_DIE];
#         return get(LAYER2, elements);
#     };

#     var getHoles = function () {
#         return get(LAYER1, Element.HOLE);
#     };

#     var isMeAlive = function () {
#         return layersString[LAYER2].indexOf(Element.ROBOT_LASER.char) == -1 &&
#             layersString[LAYER2].indexOf(Element.ROBOT_FALLING.char) == -1;
#     };

#     var barriers = null;
#     var barriersMap = null;
#     var getBarriers = function () {
#         if (!!barriers) {
#             return barriers;
#         }

#         barriers = [];
#         barriersMap = Array(size);
#         for (var x = 0; x < size; x++) {
#             barriersMap[x] = new Array(size);
#             for (var y = 0; y < size; y++) {
#                 var element1 = getAt(LAYER1, x, y);
#                 var element2 = getAt(LAYER2, x, y);

#                 barriersMap[x][y] = (
#                     element1.type == 'WALL' ||
#                     element1 == Element.HOLE ||
#                     element2 == Element.BOX ||
#                     !!element1.direction
#                 );

#                 if (barriersMap[x][y]) {
#                     barriers.push(pt(x, y));
#                 }
#             }
#         }
#         return barriers;
#     };

#     var getFromArray = function(x, y, array, def) {
#         if (x < 0 || y < 0 || x >= size || y >= size) {
#             return def;
#         }
#         return array[x][y];
#     }

#     var isBarrier = function(x, y) {
#         return getFromArray(x, y, barriersMap, true);
#     }

#     var boardAsString = function (layer) {
#         var result = "";
#         for (var i = 0; i <= size - 1; i++) {
#             result += layersString[layer].substring(i * size, (i + 1) * size);
#             result += "\n";
#         }
#         return result;
#     };

#     // thanks http://jsfiddle.net/queryj/g109jvxd/
#     String.format = function () {
#         // The string containing the format items (e.g. "{0}")
#         // will and always has to be the first argument.
#         var theString = arguments[0];

#         // start with the second argument (i = 1)
#         for (var i = 1; i < arguments.length; i++) {
#             // "gm" = RegEx options for Global search (more than one instance)
#             // and for Multiline search
#             var regEx = new RegExp("\\{" + (i - 1) + "\\}", "gm");
#             theString = theString.replace(regEx, arguments[i]);
#         }
#     }

#     var setCharAt = function(str, index, replacement) {
#         return str.substr(0, index) + replacement + str.substr(index + replacement.length);
#     }

#     var maskOverlay = function(source, mask) {
#         var result = source;
#         for (var i = 0; i < result.length; ++i) {
#             var el = Element.getElement(mask[i]);
#             if (Element.isWall(el)) {
#                 result = setCharAt(result, i, el.char);
#             }
#         }

#         return result.toString();
#     }

#     var toString = function () {
#         var temp = '0123456789012345678901234567890';

#         var result = '';

#         var layer1 = boardAsString(LAYER1).split('\n').slice(0, -1);
#         var layer2 = boardAsString(LAYER2).split('\n').slice(0, -1);
#         var layer3 = boardAsString(LAYER3).split('\n').slice(0, -1);

#         var numbers = temp.substring(0, layer1.length);
#         var space = ''.padStart(layer1.length - 5);
#         var numbersLine = numbers + '   ' + numbers + '   ' + numbers;
#         var firstPart = ' Layer1 ' + space + ' Layer2' + space + ' Layer3' + '\n  ' + numbersLine;

#         for (var i = 0; i < layer1.length; ++i) {
#             var ii = size - 1 - i;
#             var index = (ii < 10 ? ' ' : '') + ii;
#             result += index + layer1[i] +
#                     ' ' + index + maskOverlay(layer2[i], layer1[i]) +
#                     ' ' + index + maskOverlay(layer3[i], layer1[i]);


#             if (i != layer1.length - 1) {
#                 result += '\n';
#             }
#         }

#         return firstPart + '\n' + result + '\n  ' + numbersLine;
#     };
