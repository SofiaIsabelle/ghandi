# @param {Integer[]} nums
# @return {Void} Do not return anything, modify nums in-place instead.
def move_zeroes(nums)
	i = 0
	j = 0
	while i < nums.length
		if nums[i] != 0
			temp = nums[j]
			nums[j] = nums[i]
			nums[i] = temp
			j+=1
		end
		i+=1
	end
end