class Array
  alias old= []=

  def []=(index, number)
    unless number == ''
      raise ArgumentError unless (number.is_a? Fixnum) or (number.is_a? Array)
      raise ArgumentError unless number.between? 1,9
    end
    old=index,number
  end

  def repetied?
    self[0].each {|number|
      return true if self[0].count(number) >= 2
    }
    return false
  end  
end

module Sudoku end
