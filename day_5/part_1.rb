input = File.read('input.txt').strip
program = input.split(',').map(&:to_i)

program_counter = 0

def get_parameter(program, position, count)
  parameters = []
  (0...count).each do |p|
    mode = (program[position] / 10**(p+2)) % 10
    parameters[p] = mode == 0 ? program[program[position+p+1]] : program[position+p+1]
  end
  parameters
end

while true
  optcode = program[program_counter] % 100
  case optcode
  when 1
    param_1, param_2 = get_parameter(program, program_counter, 2)
    program[program[program_counter+3]] = param_1 + param_2
    program_counter += 4
  when 2
    param_1, param_2 = get_parameter(program, program_counter, 2)
    program[program[program_counter+3]] = param_1 * param_2
    program_counter += 4
  when 3
    print "Input: "
    program[program[program_counter+1]] = gets.strip.to_i
    program_counter += 2
  when 4
    param_1, _ = get_parameter(program, program_counter, 1)
    puts "Output: #{param_1}"
    program_counter += 2
  when 99
    break
  else
    puts "sth went wrong"
    break
  end

end
