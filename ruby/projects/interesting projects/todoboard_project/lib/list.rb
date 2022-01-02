require_relative 'item'

class List
    attr_accessor :label
    
    def initialize(label)
        @label = label
        @items = []
    end

    def add_item(title, deadline, description = '(blank)')
        @items << Item.new(title, deadline, description)
    end

    def size
        @items.length
    end

    def valid_index?(index)
        index > -1 and index < size
    end

    def swap(index_1, index_2)
        return false if !(valid_index?(index_1) and valid_index?(index_2))
        @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
        true
    end

    def [](index)
        @items[index]
    end

    def priority
        @items[0]
    end

    def print
        p '---------------------------------------------------'
        p @label.upcase
        p '---------------------------------------------------'
        p 'index | status | item       | Deadline      | Description   '
        p '---------------------------------------------------'
        @items.each_with_index do |item, index|
            check = item.done ? "\u2713".encode('utf-8') : ' '
            p "#{index.to_s.ljust(6)}|   [#{check}]  | #{item.title.ljust(11)}| #{item.deadline}    | #{item.description}"
        end
        p '---------------------------------------------------'
    end

    def print_full_item(index)
        return false if !valid_index?(index)
        check = @items[index].done ? "\u2713".encode('utf-8') : ' '
        p '------------------------------------------'
        p "[#{check}] #{@items[index].title.ljust(26)} #{@items[index].deadline}"
        p @items[index].description
        p '------------------------------------------'
    end

    def print_priority
        print_full_item(0)
    end

    def up(index, amount = 1)
        return false if !valid_index?(index)
        amount.times do |time|
            break if index - time <= 0
            swap(index-time, index-time-1)
        end
        true
    end

    def down(index, amount = 1)
        return false if !valid_index?(index)
        amount.times do |time|
            break if index + time >= size
            swap(index+time, index+time+1)
        end
        true
    end

    def sort_by_date!
        @items.sort_by! { |item| item.deadline.split('-').map { |date| date.length < 2 ? '0' + date[0] : date}.join }
    end

    def toggle_item(index)
        @items[index].toggle
    end

    def remove_item(index)
        return false if !valid_index?(index)
        @items.delete_at(index)
    end

    def purge
        (0..size-1).reverse_each do |index|
            @items.delete_at(index) if @items[index].done
        end
    end
end