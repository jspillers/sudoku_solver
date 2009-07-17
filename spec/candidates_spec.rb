require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../lib/puzzle'
require File.dirname(__FILE__) + '/../lib/candidates'
 
describe Candidates do
  before(:each) do
    @candidates = Candidates.new
    @a = (1..9).to_a
  end
  
  it "should create a new candidates object" do
    @candidates.kind_of?(Candidates).should be_true
  end

  it "should set x y coordinates correctly" do
    @candidates.x.should eql(0)
    @candidates.y.should eql(0)
    @candidates.xy = [1,2]
    @candidates.x.should eql(1)
    @candidates.y.should eql(2)
  end

  it "should set and get individual slot values" do
    @candidates.xy = [1,1]
    @candidates.value.should eql(@a)
    @candidates.value = [6]
    @candidates.value.should eql([6])
  end

  it "should return the correct row" do
    @candidates.xy = [1,2]
    @candidates.value = [3,4,5]
    @candidates.xy = [8,2]
    @candidates.value = [3,4,5]
    @candidates.row.should eql([@a,[3,4,5],@a,@a,@a,@a,@a,@a,[3,4,5]])
  end

  it "should return the correct column" do
    @candidates.xy = [4,2]
    @candidates.value = [3,4,5]
    @candidates.xy = [6,2]
    @candidates.value = [3,4,5]
    @candidates.row.should eql([@a,@a,@a,@a,[3,4,5],@a,[3,4,5],@a,@a])
  end

  it "should return the correct block rows" do
    @candidates.xy = [4,4]
    @candidates.value = [3,4,5]
    @candidates.block_rows.should eql(
      [
        [@a,@a,@a,@a,@a,@a,@a,@a,@a],
        [@a,@a,@a,@a,[3,4,5],@a,@a,@a,@a],
        [@a,@a,@a,@a,@a,@a,@a,@a,@a]
      ]
    )
  end

  it "should return the correct block columns" do
    @candidates.xy = [4,4]
    @candidates.value = [3,4,5]
    @candidates.xy = [4,0]
    @candidates.value = [3,4,5]
    @candidates.block_columns.should eql(
      [
        [@a,@a,@a,@a,@a,@a,@a,@a,@a],
        [[3,4,5],@a,@a,@a,[3,4,5],@a,@a,@a,@a],
        [@a,@a,@a,@a,@a,@a,@a,@a,@a]
      ]
    )
  end

  it "should return the correct block" do
    @candidates.xy = [1,5]
    @candidates.value = [3,4,5]
    @candidates.block.should eql(
      [@a,@a,@a,@a,@a,@a,@a,[3,4,5],@a]
    )
  end
end
