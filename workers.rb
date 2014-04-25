require "./sleep_queue"
require "./processor"
require "./semaphore"

class Worker

  def process
    @queue = SleepQueue.new (1..3).to_a
    @process = Processor.new  #2 processor worker
    @semaphore = Semaphore.new(2)
    @threads = []

    mutex = Mutex.new


    5.times do |i|
      @threads << Thread.new do
        while true do
          data=nil
          mutex.synchronize {
            unless @queue.empty?
              data = @queue.pop
            end
          }
          @semaphore.synchronize {
            @process.processing data, i if data
          }
        end
      end
    end

    @threads.each do |t|
      t.join
    end
  end
end


Worker.new.process