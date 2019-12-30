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
    if value.is_a?(Numeric)
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
    elsif value.is_a?(Node)
      if value.data < node.data
        if node.left == nil
          node.left = value
          return @root
        end
        insert(node.left, value)
      else
        if node.right == nil
          node.right = value
          return @root
        end#
        insert(node.right, value)
      end#
    ### if you try to insert something that isn't a number or a node ###
    else#
      puts "Error: value needs to be a number"
    end
  end

  def delete(node, value)
    #binding.pry
    ### if root node ###
    if value == node.data
      current_right = node.right
      temp_left = node.left.left
      temp_right = node.left.right
      @root = node.left
      @root.right = current_right
      insert(@root, temp_right)
      
    ### look to the left ###
    elsif value < node.data# changed from if to elsif
      if node.left == nil
        puts "#{value} not in tree"
      elsif node.left.data == value
        ### if no children then delete ###
        if node.left.left == nil && node.left.right == nil
          node.left = nil
          return @root
          #### otherwise, set it to child ####
        else
          if node.left.left == nil
            node.left = node.left.right
            
          else
            temp = node.left.right
            node.left = node.left.left
            node.left.right = temp
          end
        end
      else
        delete(node.left, value)
      end
    ### look to the right ###
    else
      if node.right == nil
        puts "#{value} not in tree"
      elsif node.right.data == value
      ### if no children then delete ###
        if node.right.left == nil && node.right.right == nil
          node.right = nil
          return @root
        #### otherwise, set it to child ####
        else
          if node.right.left == nil
            node.right = node.right.right
          else
            temp = node.right.right
            node.right = node.right.left
            node.right.right = temp
          end
        end
      else
        delete(node.right, value)
      end
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

  def level_order
    #binding.pry
    ### just to get us started ###
    queue = []
    array = []
    node = @root
  
    queue << node

    ### visit node ###
    until queue.size == 0
      temp = queue.shift
      yield temp if block_given?
      array << temp.data
      ### if children exist, enqueue them ###
      queue << temp.left if temp.left != nil
      queue << temp.right if temp.right != nil
    end
### if no block given, return the array full of values ###    
    p array if !block_given?
  end

  def inorder(node=@root, array=[])

    #binding.pry
    return if node == nil

    inorder(node.left) 
    puts node.data
    inorder(node.right)
    
    #p array if array.size > 0
### works, but not yielding to block ###
  end

  def preorder(node=@root, array=[])
    binding.pry
    return if node == nil
    if !block_given?
      array << node.data
    else
      yield node
    end

    preorder(node.left) { |x| "Node: #{x}" }
    preorder(node.right) { |x| "Node: #{x}" }
    
    p array if array.size > 0
### works, but not yielding to block ###
  end

  def postorder(node=@root, array=[])

    #binding.pry
    return if node == nil

    postorder(node.left) 
    postorder(node.right)
    puts node.data
    
    #p array if array.size > 0
### works, but not yielding to block ###
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
#tree.insert(tree.root, 2)
#tree.delete(tree.root ,8)
#p tree.find(tree.root, 23)
#tree.level_order#{ |x| puts "Node: #{x.data}" }
#tree.inorder{ |x| "Node: #{x}" }
tree.preorder{ |x| "Node: #{x.data}" }
#tree.postorder{ |x| "Node: #{x}" }
#pretty_print(tree.root)

