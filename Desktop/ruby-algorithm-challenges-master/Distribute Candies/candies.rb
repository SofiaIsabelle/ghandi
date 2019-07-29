# @param {Integer[]} candies
# @return {Integer}
def distribute_candies(candies)
    arr = [candies.uniq.length,candies.length/2]
    return arr.min
end