require "./sleep_queue"
require "./processor"
require "./semaphore"

class Producer

  def process
    @queue = SleepQueue.new (1..3).to_a
    @process = Processor.new
    @semaphore = Semaphore.new(2)
    @threads = []
    @resource = ConditionVariable.new

    @mutex = Mutex.new


    5.times do |i|
      @threads << Thread.new do
        while true do
          data=nil
          p "hehe"

          @mutex.synchronize {
            if @queue.empty?
              @resource.wait(@mutex)  #avoid keep query resource
            end
            data = @queue.pop
          }

          @semaphore.synchronize {
            @process.processing data, i if data
          }
        end
      end
    end

    Thread.new do
      while true do
        sleep 2
        data = Random.rand(100)
        @mutex.synchronize {
          @queue.push data
          @process.produce_data data
          @resource.signal
        }
      end
    end


    @threads.each do |t|
      t.join
    end
  end
end


Producer.new.process