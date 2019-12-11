RSpec.describe 'Day 11' do

  describe 'Part 2' do
    it 'has a solution' do
      expect(Runner.run_part(11, 2)).to eq "\n  ##  #  # #### ###    ## #### #  # #  #   " +
                                                    "\n #  # # #  #    #  #    # #    #  # # #    " +
                                                    "\n #  # ##   ###  #  #    # ###  #### ##     " +
                                                    "\n #### # #  #    ###     # #    #  # # #    " +
                                                    "\n #  # # #  #    # #  #  # #    #  # # #    " +
                                                    "\n #  # #  # #### #  #  ##  #    #  # #  #   "
    end
  end

end

