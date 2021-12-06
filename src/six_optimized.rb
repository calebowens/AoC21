file = File.open('./six.txt', chomp: true)

$aquarium = file.read.split(',').map(&:to_i)

def pass_day
    new_aquarium = []

    $aquarium.each do | fish |
        if fish == 0
            new_aquarium.push(6, 8)
        else
            new_aquarium.push(fish - 1)
        end
    end

    $aquarium = new_aquarium
end

for day in 0...80
    pass_day
end

puts $aquarium.size

for day in 0...(256 - 80)
    pass_day
end

puts $aquarium.size