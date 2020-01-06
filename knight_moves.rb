require 'pry'
class Board

  def draw

    puts "7 [ ][ ][ ][ ][ ][ ][ ][ ]"
    puts "6 [ ][ ][ ][ ][ ][ ][ ][ ]"
    puts "5 [ ][ ][ ][ ][ ][ ][ ][ ]"
    puts "4 [ ][ ][ ][ ][ ][ ][ ][ ]"
    puts "3 [ ][ ][ ][ ][ ][ ][ ][ ]"
    puts "2 [ ][ ][ ][ ][ ][ ][ ][ ]"
    puts "1 [ ][ ][ ][ ][ ][ ][ ][ ]"
    puts "0 [ ][ ][ ][ ][ ][ ][ ][ ]"
    puts "   0  1  2  3  4  5  6  7 "

  end

end

class Knight
  attr_reader :move1, :move2, :move3, :move4, :move5, :move6, :move7, :move8, 
              :start, :parent
  def initialize(start, depth=0, parent=nil)
    #binding.pry
    
    @parent = parent
    @start = start
    depth += 1
    @move1, @move2, @move3, @move4, @move5, @move6, @move7, @move8 = 0

    
    @move1 = start[0] + 2, start[1] + 1

    if move1[0] < 0 || move1[0] > 7 || move1[1] < 0 || move1[1] > 7
      @move1 = nil
    else
      @move1 = next_move(@move1, depth, start)
    end
    
    @move2 = start[0] + 2, start[1] - 1

    if move2[0] < 0 || move2[0] > 7 || move2[1] < 0 || move2[1] > 7
      @move2 = nil
    else
      @move2 = next_move(@move2, depth, start)
    end
    
    @move3 = start[0] + 1, start[1] + 2

    if move3[0] < 0 || move3[0] > 7 || move3[1] < 0 || move3[1] > 7
      @move3 = nil
    else
      @move3 = next_move(@move3, depth, start)
    end

    @move4 = start[0] - 1, start[1] + 2

    if move4[0] < 0 || move4[0] > 7 || move4[1] < 0 || move4[1] > 7
      @move4 = nil
    else
      @move4 = next_move(@move4, depth, start)
    end

    @move5 = start[0] - 2, start[1] + 1

    if move5[0] < 0 || move5[0] > 7 || move5[1] < 0 || move5[1] > 7
      @move5 = nil
    else
      @move5 = next_move(@move5, depth, start)
    end

    @move6 = start[0] - 2, start[1] - 1
    
    if move6[0] < 0 || move6[0] > 7 || move6[1] < 0 || move6[1] > 7
      @move6 = nil
    else
      @move6 = next_move(@move6, depth, start)
    end

    @move7 = start[0] - 1, start[1] - 2
    
    if move7[0] < 0 || move7[0] > 7 || move7[1] < 0 || move7[1] > 7
      @move7 = nil
    else
      @move7 = next_move(@move7, depth, start)
    end

    @move8 = start[0] + 1, start[1] - 2

    if move8[0] < 0 || move8[0] > 7 || move8[1] < 0 || move8[1] > 7
      @move8 = nil
    else
      @move8 = next_move(@move8, depth, start)  
    end

  end

  def next_move(current, depth, parent)

    if depth < 7 #number can be changed if needed, but any bigger and load time is bigger
      Knight.new(current, depth, parent)
    end

  end

  def level_order(destination)
    queue = []
    array = []
    node = self
  
    queue << node

    until queue.size == 0
      temp = queue.shift
      return temp if temp.start == destination
      yield temp if block_given?
      array << temp.start
      queue << temp.move1 if temp.move1 != nil
      queue << temp.move2 if temp.move2 != nil
      queue << temp.move3 if temp.move3 != nil
      queue << temp.move4 if temp.move4 != nil
      queue << temp.move5 if temp.move5 != nil
      queue << temp.move6 if temp.move6 != nil
      queue << temp.move7 if temp.move7 != nil
      queue << temp.move8 if temp.move8 != nil
    end   
    return array if !block_given?
  end

end

def knight_moves(start, destination)
  #binding.pry
  array = []
  array << destination
  knight = Knight.new(start)
  
  step = knight.level_order(destination).parent

  until step == nil
    array.unshift(step)
    step = knight.level_order(step).parent
  end
  
  puts "You made it in #{array.size - 1} moves!"
  array.each{ |x| p x }


end

#Board.new.draw

knight_moves([0, 0], [1, 2])
knight_moves([0, 0], [3, 3])
knight_moves([3, 3], [0, 0])
knight_moves([3, 3], [4, 3])
knight_moves([0, 0], [7, 7])