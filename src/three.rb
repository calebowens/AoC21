require 'enumerator'

file = File.open('three.txt', chomp: true)

numbers = file.readlines(chomp: true).map do | line | 
    line.split('').map do | number |
        number.to_f
    end
end

sum = numbers.reduce do | sum, n |
    out = []
    sum.zip(n) do | x, y |
        out << x + y
    end
    out
end

gamma_rate_binary = sum.map do | number |
    (number / numbers.length).round()
end

puts gamma_rate_binary.inspect

epsilon_rate_binary = gamma_rate_binary.map do | number |
    if number == 1
        0
    else
        1
    end
end

puts epsilon_rate_binary.inspect

def to_number (binary_array)
    out = 0
    binary_array.reverse.each_with_index do | number, index |
        out += number * (2 ** index)
    end
    out
end

gamma_rate = to_number(gamma_rate_binary)

epsilon_rate = to_number(epsilon_rate_binary)

puts "Gamma Rate: #{gamma_rate}, Epsilon Rate: #{epsilon_rate}, Combined: #{gamma_rate * epsilon_rate}"

def find_number (array)
    filtered_array = array

    for i in (array.first.length() - 1) .. 0
        counter = 0

        filtered_array.each do | number |
            counter += number[i]
        end

        most_common = (counter / filtered_array.length).round()

        filtered_array = filtered_array.select do | number |
            number[i] == most_common
        end
    end
    filtered_array.first
end

oxygen_binary = find_number(numbers)

inverse_numbers = numbers.map do | number |
    number.map do | bit |
        if bit == 0
            1.0
        else
            0.0
        end
    end
end

co2_binary = find_number(inverse_numbers)

oxygen = to_number(oxygen_binary)

co2 = to_number(co2_binary)

puts "Oxygen: #{oxygen}, Co2: #{co2}, Combined: #{oxygen * co2}"