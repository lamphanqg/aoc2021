@inputs = File.read("input.txt").chomp.split("\n")

def part1
  x_max = @inputs.first.length - 1
  y_max = @inputs.size - 1
  sum = 0

  (0..y_max).each do |y|
    (0..x_max).each do |x|
      result = true
      val = @inputs[y][x].to_i
      #check up
      unless y == 0
        result = false if val >= @inputs[y - 1][x].to_i
      end
      #check down
      unless y == y_max
        result = false if val >= @inputs[y + 1][x].to_i
      end
      #check left
      unless x == 0
        result = false if val >= @inputs[y][x - 1].to_i
      end
      #check right
      unless x == x_max
        result = false if val >= @inputs[y][x + 1].to_i
      end

      sum += 1 + val if result
    end
  end

  sum
end

p part1

def part2
  @x_max = @inputs.first.length - 1
  @y_max = @inputs.size - 1
  low_points = []
  @sizes = []

  (0..@y_max).each do |y|
    (0..@x_max).each do |x|
      result = true
      val = @inputs[y][x].to_i
      #check up
      unless y == 0
        result = false if val >= @inputs[y - 1][x].to_i
      end
      #check down
      unless y == @y_max
        result = false if val >= @inputs[y + 1][x].to_i
      end
      #check left
      unless x == 0
        result = false if val >= @inputs[y][x - 1].to_i
      end
      #check right
      unless x == @x_max
        result = false if val >= @inputs[y][x + 1].to_i
      end

      low_points << [x, y] if result
    end
  end

  low_points.each do |x, y|
    basin = { "#{x}_#{y}" => true }
    check_dirs(x, y, basin)
    @sizes << basin.keys.size
  end

  @sizes.max(3).reduce(1) { |prod, n| prod * n }
end

def check_dirs(x, y, basin)
  # check up
  unless y == 0
    if @inputs[y - 1][x] != "9" &&
       @inputs[y - 1][x].to_i >= @inputs[y][x].to_i &&
       !basin["#{x}_#{y - 1}"]
      basin["#{x}_#{y - 1}"] = true
      check_dirs(x, y - 1, basin)
    end
  end

  # check down
  unless y == @y_max
    if @inputs[y + 1][x] != "9" &&
       @inputs[y + 1][x].to_i >= @inputs[y][x].to_i &&
       !basin["#{x}_#{y + 1}"]
      basin["#{x}_#{y + 1}"] = true
      check_dirs(x, y + 1, basin)
    end
  end

  # check left
  unless x == 0
    if @inputs[y][x - 1] != "9" &&
       @inputs[y][x - 1].to_i >= @inputs[y][x].to_i &&
       !basin["#{x - 1}_#{y}"]
      basin["#{x - 1}_#{y}"] = true
      check_dirs(x - 1, y, basin)
    end
  end

  # check right
  unless x == @x_max
    if @inputs[y][x + 1] != "9" &&
       @inputs[y][x + 1].to_i >= @inputs[y][x].to_i &&
       !basin["#{x + 1}_#{y}"]
      basin["#{x + 1}_#{y}"] = true
      check_dirs(x + 1, y, basin)
    end
  end
end

p part2
