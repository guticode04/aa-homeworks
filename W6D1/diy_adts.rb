 class Stack
    attr_reader :stack
    def initialize
      # create ivar to store stack here!
      @stack_arr = []
    end

    def push(el)
      # adds an element to the stack
      stack_arr << el
    end

    def pop
      # removes one element from the stack
      stack_arr.pop
    end

    def peek
      # returns, but doesn't remove, the top element in the stack
      stack_arr.last
    end
  end

   class Queue
    attr_reader :queue
    def initialize
      # create ivar to store queue here!
      @queue_arr = []
    end

    def enqueue(el)
      # adds an element to the queue
      queue_arr.push(el)
    end

    def dequeue
      # removes one element from the queue
      queue_arr.shift
    end

    def peek
      # returns, but doesn't remove, the top element in the queue
      queue_arr.first
    end
  end

    # my_map = [[k1, v1], [k2, v2], [k3, v2], ...]
   class Map
    attr_reader :map_arr

    def initialize
      # create ivar to store Map here!
      @map_arr = []
    end

    def set(key,value)
      # adds an element to the Map
      # key value pairs will be in the subarrays
      
      pair_idx = map_arr.index { |pair| pair[0] == key }
      if pair_idx
       map_arr[pair_idx][1] = value
      else  
        map_arr.push([key, value])
      end
      value
    end

    def get(key)
      map_arr.each do |pair| 
        return pair[1] if pair[0] == key
      end
      nil
    end

    def delete(key)
      value = get(key)
      map_arr.reject! { |pair| pair[0] == key }
      value
      
    end

    def show
      map_arr
    end
 

  end