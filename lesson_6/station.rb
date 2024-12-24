require_relative './instance_counter.rb'

class Station 
  @@stations = []
  attr_reader :name, :trains
  include InstanceCounter
  extend InstanceCounter
 
  def self.all
    puts "All stations created: #{@@stations}"
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
    validate!
  end

  def trains_on_station_count
    if @trains.empty?
      puts "На станции «#{name}» нет поездов."
    else
      puts "На станции «#{name}» находится поездов: #{trains.count}."
    end
  end

  def trains_list
    puts trains
    #puts "Список поездов: #{trains}"
  end

  def trains_by_types
    trains_pass = trains.select {|t| t.type == "пассажирский"}
    trains_cargo = trains.select {|t| t.type == "грузовой"}
    puts "Pass: #{trains_pass.count}, cargo: #{trains_cargo.count}, total: #{trains.count}"
  end

  def arrive(train)
    trains << train
  end

  def depart(train)
    trains.delete(train)
  end

  protected
  def validate!
    raise "Name can't be empty." if name.nil?
    raise "Name should be at least 4 symbols." if name.length < 2
  end
end