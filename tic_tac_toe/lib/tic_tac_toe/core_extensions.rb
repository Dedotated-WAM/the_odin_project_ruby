class Array
  def all_empty?
    all? { |element| element.to_s.empty? }
  end

  def all_same?
    uniq.length <= 1
  end

  def any_empty?
    empty? || any? { |element| element.to_s.empty? }
  end

  def none_empty?
    !any_empty?
  end
end

# p Array.respond_to?(:all_empty?)
