require "./sleep_queue"
require "./processor"

class MutipleThread

  def process
    @queue = SleepQueue.new (1..100).to_a
    @process = Processor.new
    @threads = []

    semaphore = Mutex.new


    5.times do |i|
      @threads << Thread.new do
        while true do
          data=0
          semaphore.synchronize {
            unless @queue.empty?
              data = @queue.pop
            end
          }
          @process.processing data, i
        end
      end
    end

    @threads.each do |t|
      t.join
    end
  end
end


MutipleThread.new.process