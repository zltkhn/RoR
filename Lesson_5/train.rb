require_relative './manufactorer.rb'
require_relative './instance_counter.rb'

class Train
  include Manufactorer
  include InstanceCounter #методы инстанса
  extend InstanceCounter #добавляем методы класса

  attr_reader :type, :number, :train_wagons, :speed, :route
  attr_accessor :manufactorer

  @@trains = []

  def self.find(num)
    @@trains.each { |train| puts "#{train}" if train.number == num }
  end

  def initialize(number)
    @number = number
    @type = type
    @speed = 0
    @train_wagons = []
    @manufactorer
    @@trains << self
    register_instance
  end

  def show_info
    if manufactorer.nil?
      puts "Train №#{number} — #{type}, wagons: #{train_wagons.count}"
    else
      puts "Train №#{number} — #{type}, wagons: #{train_wagons.count}, manufactorer: #{manufactorer}"
    end
  end

  def current_speed
    puts speed
  end

  def speed_up(speed)
    @speed += speed
  end

  def speed_down(speed)
    @speed -= speed
  end

  def stop
    @speed = 0
  end

  def add_wagon
    if @type == :cargo
      train_wagons << CargoWagon.new
    elsif @type == :passenger
      train_wagons << PassengerWagon.new
    end
  end
 
  def delete_wagon
    train_wagons.delete_at(-1) if @train_wagons.empty? && @speed.zero?
  end

  def accept_route(route)
    @route = route
    @position = 0
    puts "Train №#{number} follows the route: #{route.stations.map(&:name)}"
    puts "Current station: «#{current_station.name}»."
  end

  def current_station
    @route.stations[@position]
  end

  def next_station
    @route.stations[@position + 1] 
  end

  def previous_station
    @route.stations[@position - 1] 
  end

  def go_next_station
    @position += 1 if next_station
  end

  def go_previous_station
    if previous_station <=1
      @position -= 1 if previous_station 
    else
      puts "The train at first station"
    end
  end

  def location
    puts "Current station «#{current_station}»."
    puts "Previous station «#{previous_station}»."
    puts "Next station «#{next_station}»."
  end

  def show_current_station_and_route
    puts "Current station «#{current_station.name}» at the Route #{route.stations.map(&:name)}"
  end

  def add_manuf
    self.add_manufactorer
  end

  def show_manuf
    self.show_manufactorer
  end
end