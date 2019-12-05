input = File.read('input.txt').strip
program = input.split(',').map(&:to_i)

program[1] = 12
program[2] = 2

program_counter = 0

while program[program_counter] != 99
  case program[program_counter]
  when 1
    program[program[program_counter+3]] = program[program[program_counter+1]] + program[program[program_counter+2]]
  when 2
    program[program[program_counter+3]] = program[program[program_counter+1]] * program[program[program_counter+2]]
  when 99
    break
  else
    puts "sth went wrong"
    break
  end
  program_counter += 4
end

puts program[0]


