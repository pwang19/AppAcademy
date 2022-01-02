def reverser(string, &proc)
    proc.call(string.reverse)
end

def word_changer(string, &proc)
    result = []
    string.split().each do |str| 
        result << proc.call(str)
    end
    result.join(' ')
end

def greater_proc_value(num, proc1, proc2)
    proc1.call(num) > proc2.call(num) ? proc1.call(num) : proc2.call(num)
end

def and_selector(arr, proc1, proc2)
    arr.select(&proc1).select(&proc2)
end

def alternating_mapper(arr, proc1, proc2)
    arr.map.with_index { |num,index| index.even? ? proc1.call(num) : proc2.call(num)}
end