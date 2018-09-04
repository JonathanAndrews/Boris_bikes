require 'dockingstation'
require 'bike'

describe DockingStation do
  it 'responds to method call release_bike' do
    expect(DockingStation.new()).to respond_to(:release_bike)
  end
  it 'responds to method call working?' do
    expect(DockingStation.new()).to respond_to(:working?)
  end
  it 'creates a new bike object when calling release_bike' do
    expect(DockingStation.new().release_bike).to be_a_kind_of(Bike)
  end
  it 'checks that the bike is working?' do
    expect(DockingStation.new().release_bike.working?).to eq true
  end
  it 'responds to method called dock_bike' do
    expect(DockingStation.new().dock_bike(Bike.new)).to be_a_kind_of(Array)
  end
end
