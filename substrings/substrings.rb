# Takes a word as first argument and an array of valid substrings as the second.  Returns a hash- listing each substring (case-insensitive) that was found in the original string and the number of times it was found.
class Substring
  def substrings(substring, dictionary)
    match_array = dictionary_matches(substring, dictionary)
    result = {}
    match_array.each do |match|
      result[match] ? result[match] += 1 : result[match] = 1
    end
    result
  end

  def dictionary_matches(substring, dictionary)
    match_array = []
    substring.downcase.split(' ').each do |word|
      substring_word = word
      dictionary.each do |entry|
        match_array << entry if substring_word.match(entry)
      end
    end
    match_array
  end
end

dictionary = %w[below down go going horn how howdy it i low own part partner sit]

p Substring.new.substrings("Howdy partner, sit down! How's it going?", dictionary)
