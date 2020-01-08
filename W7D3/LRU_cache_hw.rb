class LRUCache
    def initialize(size)
      @size = size
      @cache = []
    end

    def count
      # returns number of elements currently in cache
      @cache.length
    end

    def add(item)
      # adds element to cache according to LRU principle
      #check for inclution
      if @cache.include?(item)
        @cache.delete(item)
        @cache.push(item)
      elsif count >= size
        @cache.shift
        @cache.push(item)
      else
        @cache.push(item)
      end
    end

    def show
      # shows the items in the cache, with the LRU item first
      puts @cache
    end

    private
    # helper methods go here!

  end