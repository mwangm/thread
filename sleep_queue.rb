class SleepQueue

  def initialize data = nil
    @data = data || []
  end

  def pop
    first = @data.first
    #sleep 1
    @data = @data[1..-1]
    first
  end

  def push num
    temp_data = @data.clone
    temp_data << num
    #sleep 1
    @data = temp_data
  end

  def empty?
    @data.empty?
  end

end