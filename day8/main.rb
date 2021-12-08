inputs = File.read("input.txt").chomp.split("\n")

def part1(inputs)
  total = 0
  inputs.each do |row|
    output_part = row.split("|")[1]
    total += output_part.split(" ").count { |w| [2, 4, 3, 7].include?(w.length) }
  end

  total
end

p part1(inputs)

def part2(inputs)
  total = 0
  inputs.each do |row|
    input_part = row.split("|")[0]
    position_set = find_positions(input_part)

    output_part = row.split("|")[1]
    words = output_part.split(" ")
    digits = words.map do |w|
      case w.length
      when 2
        "1"
      when 4
        "4"
      when 3
        "7"
      when 7
        "8"
      when 6
        if w.index(position_set.mid).nil?
          "0"
        elsif w.index(position_set.rtop).nil?
          "6"
        elsif w.index(position_set.lbot).nil?
          "9"
        else
          raise "Invalid combination #{w}"
        end
      when 5
        if w.index(position_set.rtop).nil?
          "5"
        elsif w.index(position_set.rbot).nil?
          "2"
        elsif w.index(position_set.ltop).nil?
          "3"
        else
          raise "Invalid combination #{w}"
        end
      else
        raise "Invalid combination #{w}"
      end
    end

    total += digits.join.to_i
  end

  total
end

def find_positions(input_part)
  result = {}
  patterns = input_part.split(" ")

  one = patterns.find { |pt| pt.length == 2 }
  four = patterns.find { |pt| pt.length == 4 }
  seven = patterns.find { |pt| pt.length == 3 }

  top = seven.tr(one, "")
  ltop_mid = four.tr("#{one}#{top}", "")

  three = patterns.find { |pt| pt.length == 5 && pt.include?(one[0]) && pt.include?(one[1]) }
  top_mid_bot = three.tr(one, "")
  mid_bot = top_mid_bot.tr(top, "")
  mid = (ltop_mid.split("") & mid_bot.split("")).first
  ltop = ltop_mid.tr(mid, "")
  bot = mid_bot.tr(mid, "")

  five = patterns.find { |pt| pt.length == 5 && pt.include?(ltop) }
  rbot = five.tr("#{top_mid_bot}#{ltop}", "")
  rtop = one.tr(rbot, "")

  lbot = "abcdefg".tr("#{top_mid_bot}#{ltop}#{one}", "")

  PositionSet.new(
    top, mid, bot,
    ltop, lbot,
    rtop, rbot
  )
end

PositionSet = Struct.new(
  :top, :mid, :bot,
  :ltop, :lbot,
  :rtop, :rbot
)

p part2(inputs)
