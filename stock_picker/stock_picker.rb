# Takes an array of stock prices, one fo reach day. Return a pair of days representing the optimal day to buy and to sell.
class StockPicker
  def stock_picker(array)
    array.delete_at(array.index(array.min)) if array.min == array.last

    max_first_delete = array.delete_at(array.index(array.max)) if array.max == array.first

    max_value_index = array.index(array.max)

    min_value_index = array[0, max_value_index].index(array[0, max_value_index].min)

    if max_first_delete
      [min_value_index + 1, max_value_index + 1]
    else
      [min_value_index, max_value_index]
    end
  end
end

p StockPicker.new.stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10]) # exercise sample # [1,4]

p StockPicker.new.stock_picker([17, 3, 6, 9, 15, 8, 6, 10, 1]) # minimum and max first/last # [1,4]

p StockPicker.new.stock_picker(p([17, 3, 6, 9, 15, 8, 6, 10, 1].shuffle)) # minimum and max first/last # [1,4]
