# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} root
# @param {Integer} k
# @return {Integer}
def kth_smallest(root, k)
    
    $count = 0
    $result = 0
    
    def traverse(root, k)
       if root == nil
           return
       end
       
       traverse(root.left, k)
       $count = $count + 1
       if ($count == k)
           $result = root.val
       end
       traverse(root.right, k)
    end
    
    traverse(root, k)
    return $result
end