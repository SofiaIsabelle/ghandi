# @param {Integer[]} nums
# @return {Integer}
def find_max_consecutive_ones(nums)
    count = 0
    ret = 0
    for num in nums
        if num == 1
            count = count + 1
            ret = [count,ret].max
        else
            count = 0
        end
    end
    return ret
end