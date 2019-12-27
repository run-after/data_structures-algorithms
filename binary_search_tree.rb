require 'pry'
class Node
  attr_accessor :left, :data, :right
  def initialize(data, left=nil, right=nil)
    @left = left
    @data = data
    @right = right
  end
end

def build_tree(array, start=0, last=0)
  #binding.pry  
  if start > last
    return nil
  end
  #sorts and removes duplicates
  array.sort!.uniq!
  start = 0
  last = array.size
  mid = (start + last)/2
  if array[mid] != nil #this line removes empty nodes
    root = Node.new(array[mid])
    left = array[start...mid]
    right = array[mid + 1..last]
  
    root.left = build_tree(left, start, mid - 1)
    root.right = build_tree(right, mid + 1, last)
  end 
  return root
end

class Tree
  attr_reader :root
  def initialize(array)
    @root = build_tree(array)
  end

  def insert(node, value)
    #binding.pry
    if value < node.data
      if node.left == nil
        node.left = Node.new(value)
        return @root
      end
      insert(node.left, value)
    else
      if node.right == nil
        node.right = Node.new(value)
        return @root
      end
      insert(node.right, value)
    end   
  end

  def find(node, value)
    if value != node.data
      if value < node.data
        find(node.left, value)
      else
        find(node.right, value)
      end
    else
      return node
    end   
  end

end
########### thanks Fensus ####################
def pretty_print(node = root, prefix="", is_left = true)
  pretty_print(node.right, "#{prefix}#{is_left ? "│   " : "    "}", false) if node.right
  puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data.to_s}"
  pretty_print(node.left, "#{prefix}#{is_left ? "    " : "│   "}", true) if node.left
end






#p build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
#p tree.root.left.data
#tree.find(tree.root, 6345)
pretty_print(tree.find(tree.root, 6345))
