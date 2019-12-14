RSpec.describe 'IntCodeComputer' do

  describe 'instructions' do

    context '1_add' do
      it 'works for position mode' do
        program = [1, 0, 0, 0, 99]
        computer = IntCodeComputer.new(program)
        computer.run
        expect(computer.program[0]).to eq 2
      end
    end

  end

  describe 'test programs' do
    shared_examples 'runs program' do |program, input, expected_output, debug_level: 0|
      it 'output to correct output' do
        computer = IntCodeComputer.new(program)
        computer.debug_level = debug_level
        input.each do |i|
          computer.input i
        end
        computer.run
        expect(computer.output_buffer).to eq expected_output
      end
    end

    # day 5 examples
    it_behaves_like 'runs program', [3,9,8,9,10,9,4,9,99,-1,8], [8], [1]
    it_behaves_like 'runs program', [3,9,8,9,10,9,4,9,99,-1,8], [9], [0]

    it_behaves_like 'runs program', [3,9,7,9,10,9,4,9,99,-1,8], [7], [1]
    it_behaves_like 'runs program', [3,9,7,9,10,9,4,9,99,-1,8], [9], [0]

    it_behaves_like 'runs program', [3,3,1108,-1,8,3,4,3,99], [8], [1]
    it_behaves_like 'runs program', [3,3,1108,-1,8,3,4,3,99], [9], [0]

    it_behaves_like 'runs program', [3,3,1107,-1,8,3,4,3,99], [7], [1]
    it_behaves_like 'runs program', [3,3,1107,-1,8,3,4,3,99], [9], [0]


    it_behaves_like 'runs program', [3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9], [0], [0]
    it_behaves_like 'runs program', [3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9], [42], [1]

    it_behaves_like 'runs program', [3,3,1105,-1,9,1101,0,0,12,4,12,99,1], [0], [0]
    it_behaves_like 'runs program', [3,3,1105,-1,9,1101,0,0,12,4,12,99,1], [42], [1]

    day_5_larger_example = [3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104, 999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99]
    it_behaves_like 'runs program', day_5_larger_example, [7], [999]
    it_behaves_like 'runs program', day_5_larger_example, [8], [1000]
    it_behaves_like 'runs program', day_5_larger_example, [9], [1001]


  end

end
