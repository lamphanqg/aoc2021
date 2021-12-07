inputs = File.read("input.txt").chomp.split("\n")

def part1(commands)
  depth = 0
  hor_pos = 0

  commands.each do |cmd|
    parts = cmd.split(" ")
    case parts[0]
    when "forward"
      hor_pos += parts[1].to_i
    when "up"
      depth -= parts[1].to_i
    when "down"
      depth += parts[1].to_i
    end
  end

  depth * hor_pos
end

p part1(inputs)

def part2(commands)
  depth = 0
  hor_pos = 0
  aim = 0

  commands.each do |cmd|
    parts = cmd.split(" ")
    case parts[0]
    when "forward"
      hor_pos += parts[1].to_i
      depth += aim * parts[1].to_i
    when "up"
      aim -= parts[1].to_i
    when "down"
      aim += parts[1].to_i
    end
  end

  depth * hor_pos
end

p part2(inputs)
