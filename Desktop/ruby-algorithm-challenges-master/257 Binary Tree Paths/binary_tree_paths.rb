# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} root
# @return {String[]}
def binary_tree_paths(root)
    if !root
       return [] 
    end
    
    ans = []
    dfs(root, "", ans)
    return ans
end

def dfs(root, str, ans)
    if !root.left and !root.right
        ans << str+root.val.to_s
    end
    
    if root.left
        dfs(root.left, str+root.val.to_s+"->", ans)
    end
    
    if root.right
        dfs(root.right, str+root.val.to_s+"->", ans)
    end
end