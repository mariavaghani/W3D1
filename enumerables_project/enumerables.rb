require "byebug"

class Array
  def my_each(&prc)
    i = 0
    while i < self.length
      
      prc.call(self[i])
      i += 1
    end
    self
  end

  def my_select(&prc)
    new_arr = []
    self.my_each { |ele| new_arr << ele if prc.call(ele) }
    new_arr
  end

  def my_reject(&prc)
    new_arr = []
    self.my_each { |ele| new_arr << ele if !prc.call(ele) }
    new_arr
  end

  def my_any?(&prc)
    self.my_each { |ele| return true if prc.call(ele) }
    false
  end

  def my_all?(&prc)
    self.my_each { |ele| return false if !prc.call(ele) }
    true
  end

  def my_flatten
    flattened = []
    self.my_each do |ele|
      if ele.is_a?(Array)
        flattened += ele.my_flatten
      else
        flattened << ele
      end
    end
    flattened
  end

  def my_zip(*arg)
    new_arr = []
    idx = 0
    self.my_each do |first_ele| 
      zip_ele = [first_ele]
      arg.my_each { |arr| zip_ele << arr[idx]}
      idx += 1 
      new_arr << zip_ele
    end
    new_arr
  end

  def my_rotate(num = 1)
    rotated_arr = self.dup
    if num >= 0
      num.times do
        rotated_arr << rotated_arr.shift
      end
    else
      (-num).times do
        rotated_arr.unshift(rotated_arr.pop)
      end
    end
    rotated_arr
  end

  def my_join(str = "")
    joined_str = ""
    self.my_each { |ele| joined_str += ele.to_s + str }
    joined_str
  end

  def my_reverse
    reversed_arr = []
    self.my_each { |ele| reversed_arr.unshift(ele) }
    reversed_arr
  end
end


if __FILE__ == $PROGRAM_NAME
  # MY_EACH
  # return_value = [1, 2, 3].my_each do |ele|
  #   puts ele
  # end.my_each do |ele|
  #   puts ele
  # end
  # # => 1
  #     # 2
  #     # 3
  #     # 1
  #     # 2
  #     # 3

  # p return_value  # => [1, 2, 3]

  # MY SELECT
  # a = [1, 2, 3]
  # p a.my_select { |ele| ele > 1 } # => [2, 3]
  # p a.my_select { |ele| ele == 4 } # => []

  # MY REJECT

  # a = [1, 2, 3]
  # p a.my_reject { |ele| ele > 1 } # => [1]
  # p a.my_reject { |ele| ele == 4 } # => [1, 2, 3]

  # MY ALL AND MY ANY

  # a = [1, 2, 3]
  # p a.my_any? { |num| num > 1 } # => true
  # p a.my_any? { |num| num == 4 } # => false
  # p a.my_all? { |num| num > 1 } # => false
  # p a.my_all? { |num| num < 4 } # => true

  # MY FLATTEN

  # p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

  # MY ZIP

  # a = [ 4, 5, 6 ]
  # b = [ 7, 8, 9 ]
  # p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
  # p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
  # p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

  # c = [10, 11, 12]
  # d = [13, 14, 15]
  # p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

  # MY ROTATE

  # a = [ "a", "b", "c", "d" ]
  # p a.my_rotate         #=> ["b", "c", "d", "a"]
  # p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
  # p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
  # p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

  # a = [ "a", "b", "c", "d" ]
  # p a.my_join         # => "abcd"
  # p a.my_join("$")    # => "a$b$c$d"

  # MY REVERSE

  # p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
  # p [ 1 ].my_reverse               #=> [1]
end