# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} root
# @return {Boolean}
def is_balanced(root)
    return check_bal(root) != -1
end

def check_bal(root)
   if root == nil
       return 0
   end
   
   left = check_bal(root.left)
   right = check_bal(root.right)
   
   if (left == -1) or (right == -1) or ((left-right).abs > 1) 
      return -1 
   end
   
   return 1 + [left, right].max
end