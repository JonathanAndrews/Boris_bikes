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
    fail 'Sorry, all the bikes are broken' unless rotate_bikes
    @array_of_bikes.pop
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

  def rotate_bikes
    for i in 0...@array_of_bikes.count do
      if @array_of_bikes[-1].working?
        return true
      else
        @array_of_bikes.rotate!
      end
    end
    return false
  end

  def full?
    @array_of_bikes.count >= @capacity
  end

  def empty?
    @array_of_bikes.count > 0
  end
end
