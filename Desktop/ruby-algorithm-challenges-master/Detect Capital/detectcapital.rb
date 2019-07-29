# @param {String} word
# @return {Boolean}
def detect_capital_use(word)
    if word == word.upcase
        return true
    elsif word == word.downcase
        return true
    elsif word[0] == word[0].upcase and word[1..word.size] == word[1..word.size].downcase
        return true
    else
        return false
    end
end