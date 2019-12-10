module Day4
  module Part1

    def self.run(input)
      start_number, end_number = input.split('-').map(&:to_i)

      seq = []
      number = start_number.to_s.split('').map(&:to_i)

      recurring = -1
      (0..number.count-2).each do |i|
        if number[i] > number[i+1]
          recurring = number[i]
        end
        if recurring != -1
          number[i+1] = recurring
        end
      end

      while true do
        integer_number = number.join.to_i
        if integer_number >= end_number
          break
        end
        if number.group_by(&:itself).any?{ |_, v| v.count >= 2}
          seq << integer_number
        end

        (number.count-1).downto(0).each do |i|
          if number[i] == 9
            if i == 0
              number = [1] * (number.count + 1)
            end
          else
            number[i] += 1
            (i...number.count).each do |j|
              number[j] = number[i]
            end
            break
          end
        end
      end

      return seq.count
    end

  end
end

