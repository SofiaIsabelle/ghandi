# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end

# @param {ListNode} head
# @return {ListNode}
def reverse_list(head)
    
    if head == nil
        return nil
    end
    
    curr = head
    prev = nil
    nextNode = nil
    
    while curr.next != nil do
       nextNode = curr.next
       curr.next = prev
       prev = curr
       curr = nextNode
    end
    
    curr.next = prev
    return curr
    
end