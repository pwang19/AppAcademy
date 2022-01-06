class Queue
    
    def initialize
        @items = []
    end

    def enqueue(el)
        @items << el
    end

    def dequeue
        if !@items.empty?
            el = @items[0] 
            @items = @items[1..-1]
        end
        el
    end

    def peek
        @items[0]
    end
  end