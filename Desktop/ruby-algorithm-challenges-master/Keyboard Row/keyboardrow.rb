# @param {String[]} words
# @return {String[]}
def find_words(words)
    return words.select { |word| word =~ /^([qwertyuiop]*|[asdfghjkl]*|[zxcvbnm]*)$/i }
end