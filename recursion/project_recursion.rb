# ---------------------------------------------------------------------------- #
#                                 Assignment 1                                 #
# ---------------------------------------------------------------------------- #

# Using iteration, write a method #fibs which takes a number and returns an array containing that many numbers from the fibonacci sequence.
def fibs(n, result = [0, 1])
  raise ArgumentError, "The number must be a positive integer" if n.negative?
  return [0] if n.zero?
  return result if n == 1

  result << result[-2] + result[-1] while result.size < n
  result
end

# p fibs(-1) #ArgumentError
# p fibs(3.5)
# p fibs(0)
# p fibs(1)
# p fibs(5)
# p fibs(10)
# p fibs(25)

# Now write another method #fibs_rec which solves the same problem recursively. This can be done in just 3 lines (or 1 if you’re crazy, but don’t consider either of these lengths a requirement… just get it done).
def fibs_rec(n)
  raise ArgumentError, "The number must be a positive integer" if n.negative?
  return [] if n.zero?
  return [0] if n == 1
  return [0, 1] if n == 2

  sequence = fibs_rec(n - 1)

  sequence << sequence[-1] + sequence[-2]
end

# p fibs_rec(0)
# p fibs_rec(1)
# p fibs_rec(5)
# p fibs_rec(10)
# p fibs_rec(25)

# ---------------------------------------------------------------------------- #
#                                 Assignment 2                                 #
# ---------------------------------------------------------------------------- #
# Build a method #merge_sort that takes in an array and returns a sorted array, using a recursive merge sort methodology.
def merge_sort(arr)
  return arr if arr.size == 1

  middle = arr.size / 2
  left_half = arr[0...middle]
  right_half = arr[middle..arr.size]

  lh = merge_sort(left_half)
  rh = merge_sort(right_half)

  merge = proc do |left_half, right_half|
    result = []

    while !left_half.empty? && !right_half.empty?
      if left_half.first > right_half.first
        result.push(right_half.delete_at(0))
      else
        result.push(left_half.delete_at(0))
      end
    end

    result.push(left_half.delete_at(0)) until left_half.empty?

    result.push(right_half.delete_at(0)) until right_half.empty?

    result
  end
  merge.call(lh, rh)
end

simple_array = [6, 5, 4, 3, 2, 1]
small_array = [100, 80, 60, 40, 20, 0, -20]
medium_array = [9, 12, 33, 6, 2, 99, 88, 56, 3, 8, 7, 5, 5, 3, 2, 5, 76, 43, 33, 23]
large_array = [9, 12, 33, 6, 2, 99, 88, 56, 3, 8, 7, 5, 5, 3, 2, 5, 76, 43, 33, 23, 55, 77, 88, 33, 34, 66, 52, 50,
               97, 21]

p merge_sort(simple_array)
p merge_sort(small_array)
p merge_sort(medium_array)
p merge_sort(large_array)
