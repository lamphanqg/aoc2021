inputs = File.read("input.txt").chomp.split("\n")

def part1(inputs)
  len = inputs.first.length
  memo_hash = {}
  (0..len - 1).each do |i|
    memo_hash[i] = {
      "1" => 0,
      "0" => 0
    }
  end

  inputs.each do |row|
    row.each_char.with_index do |col, col_inx|
      if col == "1"
        memo_hash[col_inx]["1"] += 1
      elsif col == "0"
        memo_hash[col_inx]["0"] += 1
      end
    end
  end

  gamma = ""
  epsilon = ""
  (0..len - 1).each do |i|
    if memo_hash[i]["1"] > memo_hash[i]["0"]
      gamma << "1"
      epsilon << "0"
    else
      gamma << "0"
      epsilon << "1"
    end
  end

  gamma.to_i(2) * epsilon.to_i(2)
end

p part1(inputs)

def part2(inputs)
  len = inputs.first.length
  zero_list = []
  one_list = []
  inputs.each do |row|
    if row[0] == "1"
      one_list << row
    elsif row[0] == "0"
      zero_list << row
    end
  end

  if one_list.size >= zero_list.size
    oxygen_list = one_list
    co2_list = zero_list
  else
    oxygen_list = zero_list
    co2_list = one_list
  end

  (1..len - 1).each do |i|
    o_zero_list = []
    o_one_list = []
    if oxygen_list.size > 1
      oxygen_list.each do |row|
        if row[i] == "1"
          o_one_list << row
        elsif row[i] == "0"
          o_zero_list << row
        end
      end
      if o_one_list.size >= o_zero_list.size
        oxygen_list = o_one_list
      else
        oxygen_list = o_zero_list
      end
    end

    if co2_list.size > 1
      c_zero_list = []
      c_one_list = []
      co2_list.each do |row|
        if row[i] == "1"
          c_one_list << row
        elsif row[i] == "0"
          c_zero_list << row
        end
      end
      if c_one_list.size < c_zero_list.size
        co2_list = c_one_list
      else
        co2_list = c_zero_list
      end
    end
  end

  oxygen_list.first.to_i(2) * co2_list.first.to_i(2)
end

p part2(inputs)
