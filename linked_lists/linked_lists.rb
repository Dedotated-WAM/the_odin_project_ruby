class LinkedList
  attr_accessor :value, :head, :tail

  def initialize
    @head = nil
  end

  # append(value) adds a new node containing value to the end of the list
  def append(value)
    if @head.nil?
      @head = Node.new(value)
    else
      current_node = @head
      new_node = Node.new(value)
      current_node = current_node.next_node until current_node.next_node.nil?
      current_node.next_node = new_node
    end
  end

  # prepend(value) adds a new node containing value to the start of the list
  def prepend(value)
    if @head.nil?
      @head = Node.new(value)
    else
      current_node = @head
      new_node = Node.new(value)
      @head = new_node
      @head.next_node = current_node
    end
  end

  # size returns the total number of nodes in the list
  def size
    if @head.nil?
      count = 0
    else
      count = 1
      current_node = @head
      until current_node.next_node.nil?
        current_node = current_node.next_node
        count += 1
      end
    end
    count
  end

  # head returns the first node in the list
  def head
    if @head.nil?
      nil
    else
      at_index(0)
    end
  end

  # tail returns the last node in the list
  def tail
    if @head.nil?
      nil
    else
      current_node = @head
      current_node = current_node.next_node until current_node.next_node.nil?
    end
  end

  # at(index) returns the node at the given index
  def at_index(value)
    if @head.nil?
      'List is empty'
    elsif value <= size
      index = 0
      current_node = @head
      until index == value
        current_node = current_node.next_node
        index += 1
      end
      current_node
    else
      'Index out of range'
    end
  end

  # pop removes the last element from the list
  def pop
    if @head.nil?
      'List is empty'
    else
      current_node = @head
      current_node = current_node.next_node until current_node.next_node.next_node.nil?
      last_node = current_node.next_node
      current_node.next_node = nil
    end
    last_node
  end

  # contains?(value) returns true if the passed in value is in the list and otherwise returns false.
  def contains?(value)
    if @head.nil?
      'List is empty'
    else
      current_node = @head
      until current_node.nil?
        return true if current_node.value == value

        current_node = current_node.next_node
      end
      false
    end
  end

  # find(value) returns the index of the node containing value, or nil if not found.
  def find(value)
    if @head.nil?
      'List is empty'
    else
      current_node = @head
      index = 0
      until current_node.nil?

        if current_node.value == value
          return index
        else
          current_node = current_node.next_node
        end

        index += 1
      end
    end
    nil
  end

  # to_s represent your LinkedList objects as strings, so you can print them out and preview them in the console. The format should be: ( value ) -> ( value ) -> ( value ) -> nil

  def to_s
    if @head.nil?
      str = 'List is empty'
    else
      str = ""
      current_node = @head
      until current_node.nil?
        str += "( #{current_node.value} ) -> "
        if current_node.next_node.nil?
          str += "nil"
        end
        current_node = current_node.next_node
      end
    end
    str
  end

  def insert_at(index, value)
    if @head.nil?
      "List is empty"
    elsif index == 0
      prepend(value)
    else
      if index <= size
        i = 0
        current_node = @head
        prior_node = at_index(index - 1)
        until current_node.nil?
          if i == index
            new_node = Node.new(value)
            index_node = current_node
            current_node = new_node
            prior_node.next_node = current_node
            current_node.next_node = index_node
          end
          i += 1
          current_node = current_node.next_node
        end
      else
        "Index out of range"
      end
    end
  end

  def remove_at(index)
    if @head.nil?
      "List is empty"
    elsif index > size
      "Index out of range"
    elsif size == 1 && index == 0
      @head = nil
      return self
    elsif index == 0
      @head = @head.next_node
    else
      current_node = @head
      i = 0
      until current_node.nil?
        if i == index
          prior_node = at_index(index - 1)
          following_node = at_index(index + 1)
          prior_node.next_node = following_node
        end
        i += 1
        current_node = current_node.next_node
      end
    end
  end
end

class Node
  attr_accessor :next_node, :value

  def initialize(value)
    @next_node = nil
    @value = value
  end
end

ll = LinkedList.new
ll.append(2)
ll.append(20)
ll.append(50)
ll.prepend(1)
ll.append(75)
ll.append(100)
# p ll

p 'Head'
p ll.head
p 'Tail'
p ll.tail
p 'Size'
p ll.size
p 'At index'
p ll.at_index(2)
p ll.at_index(3)
p 'Pop'
p ll
p ll.pop
p ll.to_s
p 'Contains?'
p ll.contains?(1)
p ll.contains?(60)
p 'Find'
p ll.find(50)
p ll.find(60)
p 'to_s'
p ll.to_s
p 'Insert at'
ll.insert_at(3, 33)
ll.insert_at(0, 500)
ll.insert_at(1, 250)
p ll
p 'Remove at'
list = LinkedList.new
p list.remove_at(0)
p ll.remove_at(20)
p ll.to_s
p ll.remove_at(1)
p ll.remove_at(0)
p ll.to_s
