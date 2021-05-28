# rubocop: disable all
numbers = [1,2,3,4,5]
letters = %w[a, b, c, d, e]
colors = %w[red red yellow green blue green red purple]

# Create #my_each, a method that is identical to #each but (obviously) does not use #each. You’ll need to use a yield statement. Make sure it returns the same thing as #each as well.

# ---------------------------------------------------------------------------- #
#                                    my_each                                   #
# ---------------------------------------------------------------------------- #

module Enumerable
  def my_each
    for item in self
      yield item
    end
  end
end

# puts "--- my_each vs. each ---"
# puts "my_each"
# numbers.my_each {|item| puts item}
# puts "each"
# numbers.each {|item| puts item}

# ---------------------------------------------------------------------------- #
#                              my_each_with_index                              #
# ---------------------------------------------------------------------------- #
module Enumerable
  def my_each_with_index
    index = 0
    for item in self
      yield [index, item]
      index += 1
    end
  end
end

# puts "--- my_each_with_index vs. each_with_index---"
# puts "my_each_with_index"
# letters.my_each_with_index {|index, value| puts "Index: #{index}, Value: #{value}"}
# puts "each_with_index"
# letters.each_with_index {|value, index| puts "Index: #{index}, Value: #{value}"}

# ---------------------------------------------------------------------------- #
#                                   my_select                                  #
# ---------------------------------------------------------------------------- #
module Enumerable
  def my_select
    result = []
    self.my_each do |item|
      result << item if (yield item) == true
    end
    result
  end
end

# puts "--- my_select vs select ---"
# puts "my_select"
# p colors.my_select {|color| color == "red"}
# puts "select"
# p colors.select {|color| color == "red"}

# ---------------------------------------------------------------------------- #
#                                    my_all                                    #
# ---------------------------------------------------------------------------- #

module Enumerable
  def my_all?
    self.my_each do |item|
      next if (yield item) == true
      
      return false
    end
    true
  end
end

# puts "--- my_all? vs all? ---"
# puts "my_all?"
# p numbers.my_all? {|number| number.class == Integer}
# p colors.my_all? {|color| color == "red"}
# puts "all?"
# p numbers.all? {|number| number.class == Integer}
# p colors.all? {|color| color == "red" }


# ---------------------------------------------------------------------------- #
#                                    my_any?                                   #
# ---------------------------------------------------------------------------- #
module Enumerable
  def my_any?
    self.my_each do |item|
      next if (yield item) == false

      return true
    end
    false
  end
end

# puts "--- my_any? vs any? ---"
# puts "my_any?"
# p numbers.my_any? {|number| number >= 10}
# p numbers.my_any? {|number| number >= 3}
# p colors.my_any? {|color| color == "red"}
# p colors.my_any? {|color| color == "black"}
# puts "any?"
# p numbers.any? {|number| number >= 10}
# p numbers.any? {|number| number >= 3}
# p colors.any? {|color| color == "red"}
# p colors.any? {|color| color == "black"}

# ---------------------------------------------------------------------------- #
#                                   my_none?                                   #
# ---------------------------------------------------------------------------- #

module Enumerable
  def my_none?
    my_each do |item|
      next if (yield item) == false

      return false
    end
    true
  end
end

# puts "--- my_none? vs. none? ---"
# p colors.my_none? {|color| color == "black"}
# p colors.my_none? {|color| color == "red"}
# p numbers.my_none? {|number| number.zero?}
# p numbers.my_none? {|number| number > 3 }

# ---------------------------------------------------------------------------- #
#                                   my_count                                   #
# ---------------------------------------------------------------------------- #
module Enumerable
  def my_count
    i = 0
    my_each do |item|
      next if (yield item) == false
      i += 1
    end
    i
  end
end

# puts "--- my_count vs. count ---"
# puts "my_count"
# p numbers.my_count {|number| number > 3 }
# p numbers.my_count {|number| number > 10}
# p colors.my_count {|color| color == "red"}
# p colors.my_count {|color| color == "black"}
# puts "count"
# p numbers.count {|number| number > 3 }
# p numbers.count {|number| number > 10}
# p colors.count {|color| color == "red"}
# p colors.count {|color| color == "black"}

# ---------------------------------------------------------------------------- #
#                                    my_map                                    #
# ---------------------------------------------------------------------------- #
module Enumerable
  def my_map
    result = []
    my_each do |item|
      result << (yield item)
    end
    result
  end
end

# puts "--- my_map vs. map ---"
# puts "my_map"
# p numbers.my_map { |number| number * 2 }
# p numbers.my_map {|number| number + 1 }
# p colors.my_map {|color| "Color is #{color}" }
# puts "map"
# p numbers.map { |number| number * 2 }
# p numbers.map {|number| number + 1 }
# p colors.map {|color| "Color is #{color}" }

# ---------------------------------------------------------------------------- #
#                                   my_inject                                  #
# ---------------------------------------------------------------------------- #
module Enumerable
  def my_inject(*acc)
    return unless block_given?

    if acc.empty?
      acc = first
      array = to_a.slice(1..-1)
    else
      acc = acc[0]
      array = to_a
    end
    array.my_each do |value|
      acc = yield(acc, value)
    end
    acc
  end
end

# puts "--- my_inject vs. inject"
# puts "my_inject"
# p [2,2,2].my_inject(1) {|product, n| product * n}
# p numbers.my_inject(2) {|product, n| product * n}
# p numbers.my_inject {|sum, n| sum + n }
# puts "inject"
# p [2,2,2].inject(1) {|product, n| product * n}
# p numbers.inject(2) {|product, n| product * n}
# p numbers.inject {|sum, n| sum + n }

# Test your #my_inject by creating a method called #multiply_els which multiplies all the elements of the array together by using #my_inject
module Enumerable
  def multiply_els
    my_inject {|product, n| product * n}
  end
end
# p [2,4,5].multiply_els

# ---------------------------------------------------------------------------- #
#                     modify my_map to take a proc instead                     #
# ---------------------------------------------------------------------------- #
module Enumerable
  def my_map_modified(proc = nil)
    result = []
    if block_given? && proc.nil?
      my_each do |item|
        result << block.call(item)
      end
    else
      my_each do |item|
        result << proc.call(item)
      end
    end
    result
  end
end

p numbers.my_map_modified (Proc.new {|number| number * 2})
p numbers.my_map_modified (Proc.new {|number| number * 3})
