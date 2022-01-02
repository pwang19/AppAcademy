class Item
    attr_accessor :title, :deadline, :description, :done

    def initialize(title, deadline, description)
        raise ArgumentError.new('Invalid Date. Item not created.') if !Item.valid_date?(deadline)
        @title = title
        @deadline = deadline
        @description = description
        @done = false
    end

    def self.valid_date?(date_string)
        #YYYY-MM-DD
        date = date_string.split('-').map(&:to_i)
        return false if date.length < 3
        return false if date[1] < 1 or date[2] < 1 or date[1] > 12
        if date[1] == 2
            return false if date[0] % 4 == 0 and date[2] > 29 
            return false if date[0] % 4 != 0 and date[2] > 28
        end
        if [1, 3, 5, 7, 8, 10, 12].include?(date[1])
            return false if date[2] > 31
        else
            return false if date[2] > 30
        end
        true
    end

    def toggle
        @done = !@done
    end

end