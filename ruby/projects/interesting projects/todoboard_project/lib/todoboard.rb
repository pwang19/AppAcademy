require_relative 'list'

class TodoBoard
    def initialize
        @lists = {}
    end

    def get_command
        print "\nEnter a command: "
        cmd, *args = gets.chomp.split(' ')

        case cmd
        when 'help'
            p ''
            p 'mklist <new_list_label>'
            p '    --> make a new list with the given label'
            p ''
            p 'ls'
            p '    --> print the labels of all lists'
            p ''
            p 'showall'
            p '    --> print all lists'
            p ''
            p 'mktodo <list_label> <item_title> <item_deadline> <optional_item_description>'
            p '    --> makes a todo with the given information'
            p ''
            p 'toggle <list_label> <item_index>'
            p '    --> toggle "done" for the specified item on the given list'
            p ''
            p 'rm <list_label> <item_index>'
            p '    --> remove the specified item on the given list'
            p ''
            p 'purge <list_label>'
            p '    --> remove all "done" items on the given list'
            p ''
            p 'up <list_label> <item_index> <optional_amount>'
            p '    --> raises the todo up the given list'
            p ''
            p 'down <list_label> <item_index> <optional_amount>'
            p '    --> lowers the todo down the given list'
            p ''
            p 'swap <list_label> <item_index_1> <item_index_2>'
            p '    --> swap the positions of the specified items on the given list'
            p ''
            p 'sort <list_label>'
            p '    --> sorts the given list by deadline'
            p ''
            p 'priority <list_label>'
            p '    --> prints the todo at the top of the given list'
            p ''
            p 'print <list_label> <optional_index>'
            p '    --> prints all todos on the given list if no index is provided'
            p '    -->prints full information of the specified todo of the given list if an index is provided'
            p ''
            p 'quit'
            p '    --> quit the application'
        when 'mklist'
            @lists[args.join(' ')] = List.new(args.join(' ').downcase)
        when 'ls'
            @lists.each_key {|list_name| p list_name}
        when 'showall'
            @lists.each_value { |list| list.print }
        when 'mktodo'
            if args.length >= 3
                begin
                    @lists[args[0]].add_item(*args[1..-1])
                rescue => error
                    p error.message
                end
            end
        when 'up'
            @lists[args[0].downcase].up(args[1].to_i, args[2].to_i)
        when 'down'
            @lists[args[0].dowrcase].down(args[1].to_i, args[2].to_i)
        when 'swap'
            @lists[args[0].downcase].swap(args[1].to_i, args[2].to_i)
        when 'sort'
            @lists[args[0].downcase].sort_by_date!
        when 'priority'
            @lists[args[0].downcase].print_priority
        when 'print'
            if args.length == 0
                @lists.each_value { |list| list.print } if @lists != {}
            elsif args.length == 1
                @lists[args[0]].print if @lists != {}
            else 
                @lists[args[0]].print_full_item(args[1].to_i)
            end
        when 'toggle'
            @lists[args[0].downcase].toggle_item(args[1].to_i)
        when 'purge'
            @lists.each_value { |list| list.purge }
        when 'quit'
            return false
        else
            print "Sorry, that command is not recognized."
        end
        true
    end

    def run 
        p 'Welcome to TodoBoard!'
        p 'Type help for instructions'
        while get_command
        end
    end
end

TodoBoard.new.run