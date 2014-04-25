require "./sleep_queue"

class SingleThread

  def  process
    @queue = SleepQueue.new [1,2,3]

    Thread.new do
      while !@queue.empty? do
       t =  @queue.pop
        p  t
      end
    end.join()
  end
end


SingleThread.new.process