require 'dockingstation'
require 'bike'

describe DockingStation do
  it 'responds to method call release_bike' do
    expect(DockingStation.new()).to respond_to(:release_bike)
  end

  # it 'responds to method call working?' do
  #   expect(DockingStation.new()).to respond_to(:working?)
  # end
  it 'creates a new bike object when calling release_bike' do
    bike_1 = Bike.new
    subject.dock_bike(bike_1)
    expect(subject.release_bike).to be_a_kind_of(Bike)
  end

  it 'checks that the bike is working?' do
    bike_1 = Bike.new
    subject.dock_bike(bike_1)
    expect(subject.release_bike.working?).to eq true
  end

  # it 'responds to method called dock_bike' do
  #   expect(DockingStation.new().dock_bike(Bike.new)).to be_a_kind_of(Array)
  # end

  # it 'checks each object in the dock_bike array is a bike object' do
  #   aldgate = DockingStation.new()
  #   5.times do
  #     aldgate.dock_bike(Bike.new)
  #   end
  #   aldgate.dock_bike(Bike.new).each do |bike|
  #     expect(bike).to be_a_kind_of(Bike)
  #   end
  # end
  it 'tests that random_method returns a NoMethodError' do
    expect {subject.random_method}.to raise_error(NoMethodError)
  end

  # describe '#release_bike' do
    it 'releases the bike we dock' do
      bike_1 = Bike.new
      subject.dock_bike(bike_1)
      expect(subject.release_bike).to eq bike_1
    end
  # end
  it 'gives us a no bike available error when no bikes are available' do
    expect {subject.release_bike}.to raise_error('not enough bikes')
  end

  it 'errors out if you put in 20 or more bikes' do
    expect {(DockingStation::DEFAULT_CAPACITY+1).times{subject.dock_bike(Bike.new)}}.to raise_error('too many bikes')
  end

  it 'tests the capacity of a dockingstation when we set it to 40' do
    aldgate = DockingStation.new(40)
    expect {30.times{aldgate.dock_bike(Bike.new)}}.not_to raise_error
  end

  it "Can't fit more than 40 bikes on the bike rack" do
    aldgate = DockingStation.new(40)
    expect {41.times{aldgate.dock_bike(Bike.new)}}.to raise_error('too many bikes')
  end

  it 'expects default capacity to be 20' do
    expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
  end

  it 'lets user report that a bike is broken' do
    expect(subject).to respond_to :report_broken_and_dock
  end

  it 'method "report_broken_and_dock" stores bike marked as broken' do
    bike = Bike.new
    subject.report_broken_and_dock(bike)
    expect(bike.working?).to eq(false)
  end

  it "raises error 'Sorry, all the bikes are broken'" do
    bike = Bike.new
    subject.report_broken_and_dock(bike)
    expect {subject.release_bike}.to raise_error('Sorry, all the bikes are broken')
  end

  let(:bike) { double :bike }
  it "release unbroken bikes only" do
    allow(bike).to receive(:working?).and_return(true)
    allow(bike).to receive(:broken).and_return(true)
    good_bike = bike
    subject.dock_bike(good_bike)
    5.times do
      subject.report_broken_and_dock(bike)
    end
    expect(subject.release_bike).to eq(good_bike)
  end
end
