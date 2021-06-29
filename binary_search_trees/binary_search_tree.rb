module BinarySearchTree
  class Node
    attr_reader :value
    attr_accessor :left, :right

    def initialize(value)
      @value = value
      @left = nil
      @right = nil
    end
  end

  class Tree
    attr_accessor :root, :arr

    def initialize(arr = [])
      @arr = arr
      @root = build_tree(@arr)
    end

    def build_tree(arr = @arr.uniq.sort)
      return nil if arr.empty?
      if arr.size == 1
        # Base condition
        return Node.new(arr[0])
      else
        mid = arr.size / 2
        root = Node.new(arr[mid])
        root.left = build_tree(arr[0..(mid - 1)])
        root.right = build_tree(arr[(mid + 1)..-1])
      end

      root
    end

    def pretty_print(node = @root, prefix = "", is_left = true)
      pretty_print(node.right, "#{prefix}#{is_left ? "│   " : "    "}", false) if node.right
      puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.value}"
      pretty_print(node.left, "#{prefix}#{is_left ? "    " : "│   "}", true) if node.left
    end

    def insert(key, root = @root)
      if root.nil?
        return Node.new(key)
      elsif root.value == key
        return root
      elsif root.value < key
        root.right = insert(key, root.right)
      else
        root.left = insert(key, root.left)
      end

      root
    end

    def find(key, root = @root)
      if root.nil?
        root
      elsif root.value == key
        root
      elsif root.value < key
        root.right = find(key, root.right)
      elsif root.value > key
        root.left = find(key, root.left)
      end
    end

    def delete(key, root = @root)
      # 1. find minimum in right sub-tree (OR maximum in left)
      # 2. copy the value in the targeted node (same)
      # 3. delete duplicate from right-subtree (delete from left-subtree)

      if root.nil?
        root
      elsif key < root.value
        root.left = delete(key, root.left)
      elsif key > root.value
        root.right = delete(key, root.right)
      elsif root.left.nil? && root.right.nil? # case one: no child
        root = nil
      elsif root.left.nil? # case two: one child
        root = root.right
      elsif root.right.nil?
        root = root.left
      elsif root.right.value > root.left.value # case three: 2 children
        temp = root.right.left
        root.left = temp
        root = root.right
      end
      root
    end

    def level_order(root = @root)
      return if root.nil?

      result = []
      queue = []
      queue.push(root)
      until queue.empty?
        current_node = queue.first
        result.push(current_node.value)
        queue.push(current_node.left) unless current_node.left.nil?
        queue.push(current_node.right) unless current_node.right.nil?
        queue.shift
      end
      result
    end

    def in_order(root = @root, result = [])
      return if root.nil?

      in_order(root.left, result)
      result.push(root.value)
      in_order(root.right, result)
      result
    end

    def pre_order(root = @root, result = [])
      return if root.nil?

      result.push(root.value)
      pre_order(root.left, result)
      pre_order(root.right, result)
      result
    end

    def post_order(root = @root, result = [])
      if root.nil?
        return
      else
        post_order(root.left, result)
        post_order(root.right, result)
      end

      result.push(root.value)
    end

    def height(root = @root)
      if root.nil?
        -1
      else
        left_height = height(root.left)
        right_height = height(root.right)
        if left_height > right_height
          (left_height + 1)
        else
          (right_height + 1)
        end
      end
    end

    def node_height(node)
      root = find(node)
      height(root)
    end

    def depth(node, root = @root)
      distance = -1
      return -1 if root.nil?

      return distance + 1 if node.value == root.value

      distance = depth(node, root.left)
      return distance + 1 if distance >= 0

      distance = depth(node, root.right)
      return distance + 1 if distance >= 0

      distance
    end

    def balanced?(root = @root)
      left_height = height(root.left)
      right_height = height(root.right)

      (left_height - right_height).abs <= 1
    end

    def rebalance
      @arr = in_order
      @root = build_tree(@arr.uniq.sort)

      tree = Tree.new
      tree.root = @root
      tree.arr = @arr
      tree
    end
  end
end
