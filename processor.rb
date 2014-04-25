class Processor

  def process data
    p data
  end

  def processing data, thread
    p "#{thread} is processing #{data}"
    sleep 1
  end

  def finish_message
    p "Data process has finished."
  end

  def produce_data data
    p "Producer creates #{data}"
  end

  def no_data
    p "NO DATA!!!!!!"
  end

end