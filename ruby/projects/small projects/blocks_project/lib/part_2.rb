def all_words_capitalized?(arr)
    arr.all? {|word| word[0] == word[0].upcase && word[1..-1] == word[1..-1].downcase}
end

def no_valid_url?(arr)
    arr.none? {|url| ['.com', '.net', '.io', '.org'].include?(url[url.index('.')..-1]) }
end

def any_passing_students?(arr)
    arr.any? {|student| student[:grades].sum(0.0) / student[:grades].length > 75.0}
end