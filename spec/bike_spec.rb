require 'bike'

describe Bike do
  it 'expects an object from the Bike class to respond to the working? method' do
    expect(Bike.new()).to respond_to(:working?)
  end

  it 'checks a specific bike is broken' do
    expect(subject.broken).to eq false
  end

  it 'changes bike attribute @working to false' do
    subject.broken
    expect(subject.working?).to eq(false)
  end
end
