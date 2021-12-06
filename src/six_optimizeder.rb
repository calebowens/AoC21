file = File.open('./six.txt', chomp: true)

$age_counts = [0, 0, 0, 0, 0, 0, 0, 0, 0]

file.read.split(',').map(&:to_i).each { | fish | $age_counts[fish] += 1 }

def pass_day
    to_reset = $age_counts[0]
    $age_counts.shift
    $age_counts[6] = $age_counts[6] + to_reset
    $age_counts[8] = to_reset
end

for day in 0...80
    pass_day
end

puts $age_counts.sum

for day in 0...(256 - 80)
    pass_day
end

puts $age_counts.sum