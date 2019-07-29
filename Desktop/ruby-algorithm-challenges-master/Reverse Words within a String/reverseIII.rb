# @param {String} s
# @return {String}
def reverse_words(s)
    retStr = ""
   words = s.split(" ")
   i = 0
   while i < words.length
       retStr << words[i].reverse
       i+=1
       if i != words.length
          retStr << " " 
       end
   end
   return retStr
end