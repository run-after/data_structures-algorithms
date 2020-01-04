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
  return nil if start > last
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

  def insert(node=self.root, value)
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
    queue = []
    array = []
    node = @root
  
    queue << node

    until queue.size == 0
      temp = queue.shift
      yield temp if block_given?
      array << temp.data
      queue << temp.left if temp.left != nil
      queue << temp.right if temp.right != nil
    end   
    return array if !block_given?
  end

  def inorder(node=@root, array=[], &block)
    return if node == nil
    inorder(node.left, array, &block) 
    array << node.data if !block_given?
    yield node if block_given?
    inorder(node.right, array, &block)
    return array if !block_given?
  end

  def preorder(node=@root, array=[], &block)
    return if node == nil
    array << node.data if !block_given?
    yield node if block_given?
    preorder(node.left, array, &block) 
    preorder(node.right, array, &block)
    return array if !block_given?
  end

  def postorder(node=@root, array=[], &block)
    return if node == nil
    postorder(node.left, array, &block) 
    postorder(node.right, array, &block)
    array << node.data if !block_given?
    yield node if block_given?
    return array if !block_given?
  end

  def depth(node, level=0, deepest=0)
   # binding.pry
    if node == nil
      if deepest < level
        deepest = level
      end
    end
    return deepest if node == nil
    level += 1
    deepest = depth(node.right, level, deepest)
    deepest = depth(node.left, level, deepest)
    
    return deepest
  end

  def balanced?(level=0)
    node = self.root
    return if node == nil
    level += 1
    right = depth(node.right, level)
    left = depth(node.left, level)

    if left == right || left + 1 == right || left - 1 == right
      return true
    else
      return false
    end
  end

  def rebalance!

    temp = self.level_order
    
    @root = build_tree(temp)
    
  end

end

########### thanks Fensus ####################
def pretty_print(node = root, prefix="", is_left = true)
  pretty_print(node.right, "#{prefix}#{is_left ? "│   " : "    "}", false) if node.right
  puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data.to_s}"
  pretty_print(node.left, "#{prefix}#{is_left ? "    " : "│   "}", true) if node.left
end



tree = Tree.new(Array.new(15){rand(1..100)})
puts "Tree balanced: #{tree.balanced?}."
print "Level order:"
tree.level_order{ |x| print " #{x.data}" }
puts
print "Preorder:"
tree.preorder{ |x| print " #{x.data}" }
puts
print "Inorder:"
tree.inorder{ |x| print " #{x.data}" }
puts
print "Postorder:"
tree.postorder{ |x| print " #{x.data}" }
puts
tree.insert(105)
puts "Added!"
tree.insert(107)
puts "Added!"
tree.insert(109)
puts "Added!"
puts "Tree balanced: #{tree.balanced?}."
puts "Reobalancing tree..."
tree.rebalance!
puts "Tree balanced: #{tree.balanced?}."
print "Level order:"
tree.level_order{ |x| print " #{x.data}" }
puts
print "Preorder:"
tree.preorder{ |x| print " #{x.data}" }
puts
print "Inorder:"
tree.inorder{ |x| print " #{x.data}" }
puts
print "Postorder:"
tree.postorder{ |x| print " #{x.data}" }
puts



#pretty_print(tree.root)
