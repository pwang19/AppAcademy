class Map
    def initialize
        @map = []
    end

    def set(key, value)
        pair_location = find_index_of(key)
        if pair_location.nil?
            @map << [key, value]
        else
            @map[pair_location][1] = value
        end
    end
    
    def get(key)
        pair_location = find_index_of(key)
        if pair_location.nil?
            return nil
        else
            return @map[pair_location][1]
        end
    end 
    
    def delete(key)
        pair_location = find_index_of(key)
        if pair_location.nil?
            return nil
        else
            return @map.delete_at(pair_location)
        end
    end
        
    def show
        @map
    end

    private
    def find_index_of(key)
        pair_location = nil
        @map.each_with_index do |pair, index|
            if pair[0] == key
                pair_location = index 
                break if true
            end
        end
        pair_location
    end
end