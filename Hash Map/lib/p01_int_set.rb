require "byebug"

class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max) { false }
  end

  def insert(num)
    if num > @max || num < 0
      raise "Out of bounds" 
    else
      @store[num] = true
    end
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    return false unless @store[num] == true
    true
  end

  private

  def is_valid?(num)
    num.is_a?(Integer)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % num_buckets].push(num)
  end

  def remove(num)
    @store[num % num_buckets].delete(num)
  end

  def include?(num)
    bucket_index = num % num_buckets
    @store[bucket_index].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    # debugger
    if @count >= num_buckets
      old_nums = []
      
      @store.each do |bucket|
        bucket.each do |el|
          old_nums << el 
        end
      end

      resize!
      
      old_nums.each do |n|
        self[num].push(n)
      end
    end 
    

    unless self[num].include?(num)
      self[num].push(num)
      @count += 1 
    end 
  end

  def remove(num)
    if self[num].include?(num)
      self[num].delete(num)
      @count -= 1
    end 
  end

  def include?(num)
    self[num].include?(num)
  end

  # private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    #old_store = @store
    @store = Array.new(num_buckets * 2) { Array.new }
  end
end
