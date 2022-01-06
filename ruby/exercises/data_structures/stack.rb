class Stack
    
    def initialize
      # create ivar to store stack here!
        @items = []
    end

    def push(el)
      # adds an element to the stack
      @items << el
    end

    def pop
      # removes one element from the stack
      el = @items[-1]
      @items = @items[0..-2]
      el
    end

    def peek
      # returns, but doesn't remove, the top element in the stack
      @items[-1]
    end
  end