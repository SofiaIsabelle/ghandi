# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} root
# @return {Integer}
def sum_of_left_leaves(root)
    if root == nil
        return 0
    end
    
    if root.left and !root.left.left and !root.left.right
        return root.left.val + sum_of_left_leaves(root.right)
    end
    return sum_of_left_leaves(root.left) + sum_of_left_leaves(root.right)
end