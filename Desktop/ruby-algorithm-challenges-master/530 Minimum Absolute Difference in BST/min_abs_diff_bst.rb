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
def get_minimum_difference(root)
    
    # Credit: https://gist.github.com/pithyless/9738125
    n_bytes = [42].pack('i').size
    n_bits = n_bytes * 8
    max = 2 ** (n_bits - 2) - 1
    
    $min = max
    $prev = nil
    
    def inorderTraverse(root)
        if root == nil
            return
        end
        inorderTraverse(root.left)
        if $prev != nil
           $min = [$min, root.val - $prev.val].min 
        end
        $prev = root
        inorderTraverse(root.right)
    end
    
    inorderTraverse(root)
    return $min
end