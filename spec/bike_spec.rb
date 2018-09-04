require 'bike'

describe Bike do
  it 'expects an object from the Bike class to respond to the working? method' do
    expect(Bike.new()).to respond_to(:working?)
  end
end
