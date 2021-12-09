@input = File.read("input.txt").chomp

def part1
  positions = @input.split(",").map(&:to_i)
  min = positions.min
  max = positions.max
  min_fuel = (max - min) * (positions.size - 1)

  (min..max).each do |pos|
    total_fuel = 0
    positions.each do |org_pos|
      total_fuel += (org_pos - pos).abs
    end

    if total_fuel < min_fuel
      min_fuel = total_fuel
    end
  end

  min_fuel
end

p part1

def part2
  positions = @input.split(",").map(&:to_i)
  min = positions.min
  max = positions.max
  min_fuel = (max + min) * positions.size / 2 * (positions.size - 1)

  (min..max).each do |pos|
    total_fuel = 0
    positions.each do |org_pos|
      steps = (org_pos - pos).abs
      fuel = (steps + 1) * steps / 2
      total_fuel += fuel
    end

    if total_fuel < min_fuel
      min_fuel = total_fuel
    end
  end

  min_fuel
end

p part2
