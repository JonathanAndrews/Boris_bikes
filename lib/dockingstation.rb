require './lib/bike.rb'

class DockingStation
  DEFAULT_CAPACITY = 20
  attr_reader :bike, :capacity

  def initialize(capacity = DEFAULT_CAPACITY)
    @array_of_bikes = []
    @capacity = capacity
  end

  def release_bike
    fail 'not enough bikes' unless empty?
    @array_of_bikes.each do |bike|
      return @array_of_bikes.delete(bike) if bike.working?
    end
    fail 'Sorry, all the bikes are broken'
  end

  def dock_bike(bike)
    fail 'too many bikes' if full?
    @array_of_bikes << bike
  end

  def report_broken_and_dock(bike)
    fail 'too many bikes' if full?
    bike.broken
    @array_of_bikes << bike
  end

  private

  def full?
    @array_of_bikes.count >= @capacity
  end

  def empty?
    @array_of_bikes.count > 0
  end
end
