# Find the thousandth 1000th digit Fibonacci Number.
# You add the number with the number that preceded it in the sequence and that becomes the next number
# What is the index in the first term in the Fibonnaci Sequence to contaim 1000 digits ?

def fibonacci_digit_counter
	num1, num2, i = -1, 0, 1
    
    while i.to_s.length < 1000
    	num1 += 1; #this will be the answer to the problem
    	
    	i, num2 = num2, num2 + i
    end


    num1 

end

p fibonacci_digit_counter