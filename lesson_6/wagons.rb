require_relative './manufactorer.rb'
require_relative './instance_counter.rb'

class Wagons
  include Manufactorer
  include InstanceCounter
  @manufactorer

  attr_reader :type 
  attr_accessor :manufactorer

  PASSENGER_TYPE = :passenger
  CARGO_TYPE = :cargo

  def add_manuf
    self.add_manufactorer
  end

  def show_manuf
    self.show_manufactorer
  end
end