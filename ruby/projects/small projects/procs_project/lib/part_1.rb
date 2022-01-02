def my_map(arr, &proc)
    arr.collect(&proc)
end

def my_select(arr, &proc)
    arr.keep_if(&proc)
end

def my_count(arr, &proc)
    arr.select(&proc).length
end

def my_any?(arr, &proc)
    arr.select(&proc).length > 0
end

def my_all?(arr, &proc)
    arr.length == arr.select(&proc).length
end

def my_none?(arr, &proc)
    arr.select(&proc).length == 0
end