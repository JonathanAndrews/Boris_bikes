require 'garage'

describe Garage do

  it "receives broken bike" do
    bike = Bike.new
    bike.broken
    expect(subject.receive_bikes([bike])).to be_a(Array)
  end

  it "releases repaired bike" do
    bike = Bike.new
    subject.receive_bikes([bike])
    expect(subject.release_bikes).to eq([bike])
  end


end
