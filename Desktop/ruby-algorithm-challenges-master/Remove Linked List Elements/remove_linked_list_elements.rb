# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end

# @param {ListNode} head
# @param {Integer} val
# @return {ListNode}
def remove_elements(head, val)
    
    curr = head
    prev = head
    ret = head
    
    while curr != nil do
        if curr.val == val
            # Check if head
            if curr == ret
                ret = curr.next
                prev = ret
            else
                prev.next = curr.next
            end
        else
            prev = curr
        end
        curr = curr.next
    end
    
    return ret
end