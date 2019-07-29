# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} s
# @param {TreeNode} t
# @return {Boolean}
def is_subtree(s, t)
    
    def is_same(s, t)
        if s == nil and t == nil
            return true
        end
        
        if s == nil or t == nil
            return false
        end
        
        if s.val != t.val
            return false
        end
        
        return (is_same(s.left, t.left) and is_same(s.right, t.right))
    end
    
    if s == nil
        return false
    end
    
    if is_same(s, t)
        return true
    end
    
    return (is_subtree(s.left, t) or is_subtree(s.right, t))
end