@inputs = File.read("input.txt").chomp.split("\n")

PAIRS = {
  "(" => ")",
  "[" => "]",
  "{" => "}",
  "<" => ">"
}

def part1
  point = {
    ")" => 3,
    "]" => 57,
    "}" => 1197,
    ">" => 25137
  }
  total = 0
  @inputs.each do |row|
    memo = []
    row.each_char do |char|
      if ["(", "[", "{", "<"].include?(char)
        memo << char
      else
        last_one = memo.pop
        if PAIRS[last_one] != char
          total += point[char]
          break
        end
      end
    end
  end

  total
end

p part1

def part2
  point = {
    "(" => 1,
    "[" => 2,
    "{" => 3,
    "<" => 4
  }

  totals = []
  @inputs.each do |row|
    total = 0
    memo = []
    corrupted = false

    row.each_char do |char|
      if ["(", "[", "{", "<"].include?(char)
        memo << char
      else
        last_one = memo.pop
        if PAIRS[last_one] != char
          corrupted = true
          break
        end
      end
    end
    next if corrupted

    memo.size.times do
      last_one = memo.pop
      total = total * 5 + point[last_one]
    end

    totals << total if total > 0
  end

  totals.sort[totals.length / 2]
end

p part2
