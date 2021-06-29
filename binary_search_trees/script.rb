require_relative "binary_search_tree"

puts "--- Binary Search Trees ---"

# Create a binary search tree from an array of random numbers (Array.new(15) { rand(1..100) })
tree = BinarySearchTree::Tree.new(Array.new(15) { rand(1..100) })
p tree.pretty_print

# Confirm that the tree is balanced by calling #balanced?
p "balanced? : #{tree.balanced?}"

# Print out all elements in level, pre, post, and in order
p "level"
p tree.level_order
p "pre-order"
p tree.pre_order
p "post-order"
p tree.post_order
p "in-order"
p tree.in_order

# Unbalance the tree by adding several numbers > 100
tree.insert(150)
tree.insert(300)
tree.insert(400)

# Confirm that the tree is unbalanced by calling #balanced?
p tree.pretty_print
p "balanced? : #{tree.balanced?}"

# Balance the tree by calling #rebalance
tree = tree.rebalance

# Confirm that the tree is balanced by calling #balanced?
p "balanced? : #{tree.balanced?}"
# Print out all elements in level, pre, post, and in order
p tree.pretty_print
p "level"
p tree.level_order
p "pre-order"
p tree.pre_order
p "post-order"
p tree.post_order
p "in-order"
p tree.in_order
