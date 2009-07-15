require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../lib/puzzle'
 
describe Puzzle do
  before(:each) do
    @puzzle = Puzzle.new
  end

  it "should create a new puzzle" do
    @puzzle.kind_of?(Puzzle).should be_true
  end

  it "should not be solved" do
    @puzzle.solved?.should be_false
  end
end
