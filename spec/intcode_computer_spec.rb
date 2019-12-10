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

end
