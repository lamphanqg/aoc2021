@input = File.read("input.txt")
@pos_lines = @input.split("\n\n")[0].split("\n")
@fold_lines = @input.split("\n\n")[1].split("\n")

def part1
  fold = @fold_lines[0].sub("fold along ", "")
  fold_dir = fold.split("=")[0]
  fold_val = fold.split("=")[1].to_i

  if fold_dir == "x"
    fold_idx = 0
  else
    fold_idx = 1
  end

  @pos_lines.map do |pos|
    pos_arr = pos.split(",")
    next pos if pos_arr[fold_idx].to_i <= fold_val

    pos_arr[fold_idx] = 2 * fold_val - pos_arr[fold_idx].to_i
    pos_arr.join(",")
  end.uniq.size
end

p part1

def part2
  fold_x = []
  fold_y = []

  @fold_lines.each do |fold_line|
    fold = fold_line.sub("fold along ", "")
    fold_dir = fold.split("=")[0]
    fold_val = fold.split("=")[1].to_i

    if fold_dir == "x"
      fold_x << fold_val
    else
      fold_y << fold_val
    end
  end

  matrix = []
  max_x = 0
  max_y = 0
  @pos_lines.each do |pos_line|
    x = pos_line.split(",")[0].to_i
    y = pos_line.split(",")[1].to_i

    fold_x.each do |fold|
      next if x <= fold

      x = 2 * fold - x
    end

    fold_y.each do |fold|
      next if y <= fold

      y = 2 * fold - y
    end

    max_x = [x, max_x].max
    max_y = [y, max_y].max
    matrix << { x: x, y: y }
  end

  strs = []
  (0..max_y).each do |row|
    strs << "." * (max_x + 1)
  end

  matrix.each do |h|
    strs[h[:y]][h[:x]] = "#"
  end

  strs.each { |row| p row }
end

part2
