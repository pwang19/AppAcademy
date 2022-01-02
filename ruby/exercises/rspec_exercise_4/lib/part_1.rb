def my_reject(array, &prc)
    array - array.select(&prc)
end

def my_one?(array, &prc)
    array.select(&prc).length == 1
end

def hash_select(hash, &prc)
    hash.filter(&prc)
end

def xor_select(array, prc1, prc2)
    el1 = array.select(&prc1)
    el2 = array.select(&prc2)
    el1 + el2 - (el1 & el2)
end