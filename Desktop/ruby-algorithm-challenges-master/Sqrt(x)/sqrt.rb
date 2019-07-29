# @param {Integer} x
# @return {Integer}
def my_sqrt(x)
    r = x
    while (r*r > x) do
        r = (r + x/r) / 2
    end
    return r
end