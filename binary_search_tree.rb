class Node
  attr_accessor :left, :data, :right
  def initialize(data, left=nil, right=nil)
    @left = left
    @data = data
    @right = right
  end
end

def build_tree(array)
  #sorts and removes duplicates
  array.sort!.uniq!

  node = Node.new(array[array.size/2])
end


p build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
