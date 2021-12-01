require 'enumerator'

file = File.open('one.txt', chomp: true)

data = file.readlines.map do | entry |
    entry.to_i
end

increases = 0

data.each_cons(2) do | first, second |
    if second > first 
        increases += 1
    end
end

puts "Increases: ", increases

batchedIncreases = 0

data.drop(3).each_index do | index |
    first = data[index] + data[index + 1] + data[index + 2]
    second = data[index + 1] + data[index + 2] + data[index + 3]

    if second > first
        batchedIncreases += 1
    end
end

puts "Batched Increases: ", batchedIncreases