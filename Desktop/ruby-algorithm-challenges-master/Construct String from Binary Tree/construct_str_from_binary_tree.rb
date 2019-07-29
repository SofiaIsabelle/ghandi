# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} t
# @return {String}
def tree2str(t)
    def traverse(root)
        if root == nil
            return ""
        end
        s = root.val.to_s
        left = traverse(root.left)
        right = traverse(root.right)
        if left == "" and right == ""
            return s
        elsif left == ""
            s = s + "()" + "(" + right + ")"
        elsif right == ""
            s = s + "(" + left + ")"
        else
            s = s + "(" + left + ")" + "(" + right + ")"
        end
        return s
    end
    return traverse(t)
end