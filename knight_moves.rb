class Board
  def initialize
    

  end

  def draw

    puts "7 [ ][ ][ ][ ][ ][ ][ ][ ]"
    puts "6 [ ][ ][ ][ ][ ][ ][ ][ ]"
    puts "5 [ ][ ][ ][ ][ ][ ][ ][ ]"
    puts "4 [ ][ ][ ][ ][ ][ ][ ][ ]"
    puts "3 [ ][ ][ ][ ][ ][ ][ ][ ]"
    puts "2 [ ][ ][7][ ][ ][ ][ ][ ]"
    puts "1 [ ][ ][ ][ ][ ][ ][ ][ ]"
    puts "0 [ ][ ][ ][ ][ ][ ][ ][ ]"
    puts "   0  1  2  3  4  5  6  7 "

  end

end

class Knight
  attr_reader :move1, :move2, :move3, :move4, :move5, :move6, :move7, :move8
  def initialize(start)
    
    @start = start

    @move1 = start[0] + 2, start[1] + 1
    @move1 = nil if move1[0] < 0 || move1[0] > 7 || move1[1] < 0 || move1[1] > 7

    @move2 = start[0] + 2, start[1] - 1
    @move2 = nil if move2[0] < 0 || move2[0] > 7 || move2[1] < 0 || move2[1] > 7

    @move3 = start[0] + 1, start[1] + 2
    @move3 = nil if move3[0] < 0 || move3[0] > 7 || move3[1] < 0 || move3[1] > 7

    @move4 = start[0] - 1, start[1] + 2
    @move4 = nil if move4[0] < 0 || move4[0] > 7 || move4[1] < 0 || move4[1] > 7

    @move5 = start[0] - 2, start[1] + 1
    @move5 = nil if move5[0] < 0 || move5[0] > 7 || move5[1] < 0 || move5[1] > 7

    @move6 = start[0] - 2, start[1] - 1
    @move6 = nil if move6[0] < 0 || move6[0] > 7 || move6[1] < 0 || move6[1] > 7

    @move7 = start[0] - 1, start[1] - 2
    @move7 = nil if move7[0] < 0 || move7[0] > 7 || move7[1] < 0 || move7[1] > 7

    @move8 = start[0] + 1, start[1] - 2
    @move8 = nil if move8[0] < 0 || move8[0] > 7 || move8[1] < 0 || move8[1] > 7

  end

  def next_move(current)

    return Knight.new(current)

  end

end

Board.new.draw
knight = Knight.new([2, 2])
p knight
p knight.next_move(knight.move3)
#p knight.next_move(knight.move3).move3