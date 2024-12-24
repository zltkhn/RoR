require_relative './manufactorer.rb'
require_relative './instance_counter.rb'

class Train
  include Manufactorer
  include InstanceCounter
  extend InstanceCounter

  attr_reader :type, :number, :train_wagons, :speed, :route
  attr_accessor :manufactorer

  @@trains = []
  NUMBER_FROMAT = /^[a-яa-z0-9]{3}(-|)[a-яa-z0-9]{2}$/i


  def self.find(num)
   puts @@trains.find{|train| train.number == num}
  end

  def initialize(number)
    @number = number.to_s
    @type = type
    @speed = 0
    @train_wagons = []
    @manufactorer
    @@trains << self
    register_instance
    validate! 
  end


  def valid?
    validate!
      true # возвращаем true, если метод validate! не выбросил исключение
    rescue
      false # возвращаем false, если было исключение
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
    puts "Train №#{number} => route: #{route.stations.map(&:name)}, current station: #{current_station.name}"
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
    if previous_station <= 1
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
    puts "Station «#{current_station.name}» at route #{route.stations.map(&:name)}"
  end

  def add_manuf
    self.add_manufactorer
  end

  def show_manuf
    self.show_manufactorer
  end

protected
  def validate!
    raise "Number can't be empty." if number.nil?
    raise "Number should be at least 5 symbols." if number.length < 5
    raise "Number has invalid format." if number !~ NUMBER_FROMAT
  end
end