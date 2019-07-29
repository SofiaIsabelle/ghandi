# @param {Integer} n
# @return {String[]}
def fizz_buzz(n)
i = 1
retArr = Array.new
while i < n+1
	if i % 3 == 0 and i % 5 == 0
		retArr.push("FizzBuzz")
	elsif i % 3 == 0
		retArr.push("Fizz")
	elsif i % 5 == 0
		retArr.push("Buzz")
	else
		retArr.push(i.to_s)
	end
	i = i+1
end
return retArr
end