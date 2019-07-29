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
$answer = 0
def find_tilt(root)
    $answer = 0
    def sum(root)
        if root == nil
            return 0
        end
    
        left = sum(root.left)
        right = sum(root.right)

        $answer += (left - right).abs
    
        return root.val + left + right
    end
    
    sum(root)
    return $answer

end