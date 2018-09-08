require 'bike'

class Garage

  def initialize
    @store = []
  end

  def receive_bikes(bikes)
    bikes.each do |bike|
      bike.fix
    end
    @store.push(*bikes)

  end

  def release_bikes
    fixed_bikes = []
    fixed_bikes.push(*@store)
    @store = []
    fixed_bikes

  end

end
