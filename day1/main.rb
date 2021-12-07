require "benchmark"
inputs = File.read("input.txt").chomp.split("\n").map(&:to_i)

def part1(input_arr)
  total = 0
  prev = input_arr.shift

  input_arr.each do |input|
    total += 1 if input > prev
    prev = input
  end

  total
end

def part2(input_arr)
  total = 0
  prev = input_arr.first(3).sum

  input_arr[1..-2].each_with_index do |_, inx|
    cur_slide = input_arr[inx, 3].sum
    total += 1 if cur_slide > prev
    prev = cur_slide
  end

  total
end

def part2_2(input_arr)
  total = 0
  (3..input_arr.size - 1).each do |inx|
    total += 1 if input_arr[inx] > input_arr[inx - 3]
  end

  total
end

# p count_increase(inputs)

# sample_inputs = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263, 280]
# p part2_2(inputs)
n = 10_000

Benchmark.bmbm do |x|
  x.report("part2") { n.times { part2(inputs) } }
  x.report("part2_2") { n.times { part2_2(inputs) } }
end
