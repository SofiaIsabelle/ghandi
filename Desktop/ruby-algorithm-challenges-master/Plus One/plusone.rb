# @param {Integer[]} digits
# @return {Integer[]}
def plus_one(digits)
    sum = digits.join('').to_i + 1
    return sum.to_s.split('').map(&:to_i)
end