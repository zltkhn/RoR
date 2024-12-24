class PassengerWagon < Wagons
  def initialize
    @type = :passenger
    @manufactorer
    super
  end

  def add_manuf
    self.add_manufactorer
  end

  def show_manuf
    self.show_manufactorer
  end
end