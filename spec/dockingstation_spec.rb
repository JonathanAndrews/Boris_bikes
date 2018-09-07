require 'dockingstation'
require 'bike'

describe DockingStation do

  let(:double_bike) { double :bike }
  let(:broken_bike) { double :bike }

  it 'responds to method call release_bike' do
    expect(DockingStation.new()).to respond_to(:release_bike)
  end

  it 'checks that the bike is working?' do
    allow(double_bike).to receive(:working?).and_return(true)
    subject.dock_bike(double_bike)
    expect(subject.release_bike.working?).to eq true
  end

  it 'tests that random_method returns a NoMethodError' do
    expect {subject.random_method}.to raise_error(NoMethodError)
  end

  # describe '#release_bike' do
    it 'releases the bike we dock' do
      allow(double_bike).to receive(:working?).and_return(true)
      subject.dock_bike(double_bike)
      expect(subject.release_bike).to eq(double_bike)
    end
  # end
  it 'gives us a no bike available error when no bikes are available' do
    expect {subject.release_bike}.to raise_error('not enough bikes')
  end

  it 'errors out if you put in 20 or more bikes' do
    expect {(DockingStation::DEFAULT_CAPACITY+1).times{subject.dock_bike(double_bike)}}.to raise_error('too many bikes')
  end

  it 'tests the capacity of a dockingstation when we set it to 40' do
    aldgate = DockingStation.new(40)
    expect {30.times{aldgate.dock_bike(double_bike)}}.not_to raise_error
  end

  it "Can't fit more than 40 bikes on the bike rack" do
    aldgate = DockingStation.new(40)
    expect {41.times{aldgate.dock_bike(double_bike)}}.to raise_error('too many bikes')
  end

  it 'expects default capacity to be 20' do
    expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
  end

  it 'lets user report that a bike is broken' do
    expect(subject).to respond_to :report_broken_and_dock
  end

  it 'method "report_broken_and_dock" stores bike marked as broken' do
    allow(double_bike).to receive(:broken)
    allow(double_bike).to receive(:working?).and_return(false)
    bike = double_bike
    subject.report_broken_and_dock(bike)
    expect(bike.working?).to eq(false)
  end

  it "raises error 'Sorry, all the bikes are broken'" do
    allow(double_bike).to receive(:broken)
    allow(double_bike).to receive(:working?).and_return(false)
    bike = double_bike
    subject.report_broken_and_dock(bike)
    expect {subject.release_bike}.to raise_error('Sorry, all the bikes are broken')
  end

  it "release unbroken bikes only" do
    allow(double_bike).to receive(:working?).and_return(true)
    allow(double_bike).to receive(:broken)
    good_bike = double_bike
    subject.dock_bike(good_bike)
    5.times do
      subject.report_broken_and_dock(double_bike)
    end
    expect(subject.release_bike).to eq(good_bike)
  end

  it "should release broken bikes for repair" do
    allow(double_bike).to receive(:broken)
    allow(double_bike).to receive(:working?).and_return(false)
    station = DockingStation.new
    station.report_broken_and_dock(double_bike)
    expect(station.release_broken_bikes).to eq [double_bike]
  end

  it "should release broken bikes for repair when there is also a working bike" do
    allow(double_bike).to receive(:broken)
    allow(double_bike).to receive(:working?).and_return(true)
    allow(broken_bike).to receive(:broken)
    allow(broken_bike).to receive(:working?).and_return(false)
    station = DockingStation.new
    station.report_broken_and_dock(broken_bike)
    station.dock_bike(double_bike)
    expect(station.release_broken_bikes).to eq [broken_bike]
  end


end
