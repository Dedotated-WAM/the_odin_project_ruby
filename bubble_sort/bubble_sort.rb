# Takes an array and returns a sorted array using the bubble sort methodology.
def bubble_sort(array)

  # # using 'each'
  array.each do |i|
    n = 0
    array.each do |j|
      if array.length - array.index(j) > 1
        if array[n] > array[n + 1]
          array[n], array[n + 1] = array[n + 1], array[n]
        end
        n += 1
      end
    end
    array
  end

  # using 'for' 
#   for i in (0..array.length)
#     for j in (0..(array.length - 2))
#       if array[j] > array[j + 1]
#         array[j], array[j + 1] = array[j + 1], array[j]
#       end
#     end
#   end
#   array
end

p bubble_sort([4,3,78,2,0,2])
p bubble_sort([10,9,8,7,6,5,4,3,2,1,0])
