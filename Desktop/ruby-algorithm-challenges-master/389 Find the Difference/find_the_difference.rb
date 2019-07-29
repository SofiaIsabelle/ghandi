# @param {String} s
# @param {String} t
# @return {Character}
def find_the_difference(s, t)
    ss = s.chars.sort.join
    tt = t.chars.sort.join
    j = 0
    
    tt.split("").each do |i|
       if i != ss[j] 
            return i
       end
        j = j + 1
    end
    
    return nil
end