file = File.open('./six.txt', chomp: true)

class LanternFish
    def initialize (age = 8)
        @age = age
    end

    def age
        if @age == 0
            @age = 6
            LanternFish.new()
        else
            @age -= 1
            nil
        end
    end
end

$aquarium = file.read.split(',').map { | age | LanternFish.new(age.to_i) }

def pass_day
    new_aquarium = []
    $aquarium.each do | fish |
        baby = fish.age()

        if baby
            new_aquarium.push baby
        end

        new_aquarium.push fish
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