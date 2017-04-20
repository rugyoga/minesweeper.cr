require "./spec_helper"

describe Board do
  # TODO: Write tests

  it "is empty after new" do
    board = Board(Int32).new(2, 2, -1)
    board.get(0, 0).should eq(-1)
    board.get(0, 1).should eq(-1)
    board.get(1, 0).should eq(-1)
    board.get(1, 1).should eq(-1)
  end

  it "is set" do
    board = Board(Int32).new(2, 2, -1)
    board.set(1, 1, 0)
    board.get(0, 0).should eq(-1)
    board.get(0, 1).should eq(-1)
    board.get(1, 0).should eq(-1)
    board.get(1, 1).should eq(0)
  end

  it "is legal" do
    board = Board(Int32).new(2, 2, -1)
    board.legal?(0,0).should be_true
    board.legal?(0,1).should be_true
    board.legal?(1,0).should be_true
    board.legal?(1,1).should be_true
    board.legal?(-1,0).should be_false
    board.legal?(0,-1).should be_false
    board.legal?(2,0).should be_false
    board.legal?(2,2).should be_false
  end

  it "is adjacent" do
    board = Board(Int32).new(2, 2, -1)
    board.adjacencies(0,0).should eq([{1,0},{0,1},{1,1}])
    board.adjacencies(0,1).should eq([{0,0},{1,0},{1,1}])
    board.adjacencies(1,0).should eq([{0,0},{0,1},{1,1}])
    board.adjacencies(1,1).should eq([{0,0},{1,0},{0,1}])
  end

  it "is adjacent_match" do
    board = Board(Int32).new(2, 2, -1)
    board.set(1, 1, 0)
    board.adjacent_match(0,0,-1).should eq([{1,0},{0,1}])
    board.adjacent_match(0,1,-1).should eq([{0,0},{1,0}])
    board.adjacent_match(1,0,-1).should eq([{0,0},{0,1}])
    board.adjacent_match(1,1,-1).should eq([{0,0},{1,0},{0,1}])
    board.adjacent_match(0,0,0).should eq([{1,1}])
    board.adjacent_match(0,1,0).should eq([{1,1}])
    board.adjacent_match(1,0,0).should eq([{1,1}])
    board.adjacent_match(1,1,0).should eq([] of {Int32,Int32})
  end

  it "is adjacent?" do
    board = Board(Int32).new(3, 3, -1)
    board.adjacent?(0,0,0,1).should be_true
    board.adjacent?(0,0,1,0).should be_true
    board.adjacent?(0,0,1,1).should be_true
    board.adjacent?(0,0,2,0).should be_false
    board.adjacent?(0,0,2,1).should be_false
    board.adjacent?(0,0,2,0).should be_false
    board.adjacent?(0,0,1,2).should be_false
    board.adjacent?(0,0,0,2).should be_false
  end

  it "is triples" do
    board = Board(Int32).new(2, 2, -1)
    board.set(1, 1, 0)
    board.triples.should eq([{0,0,-1}, {1,0,-1},{0,1,-1},{1,1,0}])
  end
end
