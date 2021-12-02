file = File.open('two.txt', chomp: true)

depth = 0
distance = 0

class Statement < String
    def key()
        split[0]
    end

    def value()
        split[1].to_i()
    end
end

lines = file.readlines()

lines.each do | rawStatement |
    statement = Statement.new(rawStatement)

    case statement.key()
    when "forward"
        distance += statement.value()
    when "down"
        depth += statement.value()
    when "up"
        depth -= statement.value()
    end
end

puts "Depth: #{depth}, Distance: #{distance}, Final: #{depth * distance}"

depth = 0
distance = 0

pointer = 0

lines.each do | rawStatement |
    statement = Statement.new(rawStatement)

    case statement.key()
    when "forward"
        increment = statement.value()

        distance += increment
        depth += increment * pointer
    when "down"
        pointer += statement.value()
    when "up"
        pointer -= statement.value()
    end
end

puts "Depth: #{depth}, Distance: #{distance}, Pointer: #{pointer} Final: #{depth * distance}"