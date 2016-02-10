require 'tree'

root_node = Tree::TreeNode.new("Null","root Content")

# root_node.print_tree

root_node << Tree::TreeNode.new("1", "Child1 Content") << Tree::TreeNode.new("3", "GrandChild1 Content")
root_node << Tree::TreeNode.new("2", "Child2 Content")
# root_node.print_tree
# child1 = root_node['1']

root_node.each do |node|
	puts node
end
