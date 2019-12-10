module Day7
  module Part2

    def self.run(input)
      program = input.split(',').map(&:to_i)

      max_thrust = 0
      (5..9).to_a.permutation.each do |permutation|
        current_output = 0
        computers = []
        (0..4).each do |i|
          computer = IntCodeComputer.new(program.clone)
          computer.input permutation[i]
          computers << computer
        end
        computers[0].input 0
        while computers[4].state != :halted
          (0..3).each do |i|
            computers[i].run
            computers[i+1].input(computers[i].output)
          end
          computers[4].run
          current_output = computers[4].output
          computers[0].input current_output
        end

        if current_output > max_thrust
          max_thrust = current_output
        end
      end

      return max_thrust
    end

  end
end

