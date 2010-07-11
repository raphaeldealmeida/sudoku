require 'sudoku'

describe Sudoku do

  describe 'square' do
  
    before :each do
      @square = [[1,2,3],
                 [4,5,6],
                 [7,8,9]]
    end    

    it 'should have three rows' do
      @square.should have(3).rows
    end

    it 'should have three columns' do
      @square.each { |row|
        row.should have(3).columns
      }
    end
    
    context 'when is atributed a value' do
      it 'should allow numbers' do
        lambda { @square[0][0] = 2 }.should_not raise_exception(ArgumentError)
      end

      it 'should deny no-numbers' do
        lambda { @square[0][0] = 'a' }.should raise_exception(ArgumentError)
      end

      it 'should not allow numbers out 1 until 9' do
        lambda { @square[0][0] = 10 }.should raise_exception(ArgumentError)
        lambda { @square[0][0] = 0 }.should raise_exception(ArgumentError)
          
      end

      it 'should not have repetied numbers' do
        @square[0][0] = 2
        @square[0][1] = 2
        @square.repetied?.should be_true
      end

      it 'should have numbers without repetition' do
        @square.repetied?.should be_false
      end
    end
  end

end
