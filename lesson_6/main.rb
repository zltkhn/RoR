require_relative './route.rb'
require_relative './station.rb'
require_relative './train.rb'
require_relative './wagons.rb'
require_relative './cargo_train.rb'
require_relative './passenger_train.rb'
require_relative './cargo_wagon.rb'
require_relative './passenger_wagon.rb'
require_relative './instance_counter.rb'
require_relative './manufactorer.rb'

class RailRoad
  attr_reader :all_routes, :all_stations, :all_trains, :action
  
  def initialize
    @all_routes = []
    @all_stations = []
    @all_trains = []
  end
                  
  def start
    loop do
      menu
      choose(gets.chomp.to_i)
    end
  end

  def menu
    puts
    puts " 1 - Create station"
    puts " 2 - Create train"
    puts " 3 - Create route"
    puts " 4 - Add station to route"
    puts " 5 - Delete station from route" 
    puts " 6 - Assign route to train"
    puts " 7 - Add wagons to train"
    puts " 8 - Delete wagons from train"
    puts " 9 - Move train by route"
    puts "10 - Show routs list"
    puts "11 - Show stations list"
    puts "12 - Show trains list"
    puts "13 - Add/edit/show manufactorer"
    puts "14 - Train info"
    puts "15 - Find train"
    puts "0 - Exit"
    puts
    print "Сhoose an action: "
  end
        
  def choose(action)
    case action
      when 1 then create_station
      when 2 then create_train
      when 3 then create_route
      when 4 then add_station_to_route
      when 5 then delete_station_from_route
      when 6 then assign_route_to_train
      when 7 then add_wagons_to_train
      when 8 then delete_wagons_from_train
      when 9 then move_train
      when 10 then show_routs_list
      when 11 then show_stations_list
      when 12 then show_trains_list
      when 13 then add_show_manufactorer
      when 14 then train_info
      when 15 then find_train
      when 0 then exit
      else
        start
      end
    end

protected
  def create_station #1
    begin
      name = enter_station_name
      all_stations << Station.new(name)
      puts "Station #{name} created."
    rescue RuntimeError => e
      puts e.message
      retry
    end 
  end

  def create_train #2
    begin
      num = create_train_num
      create_train_by_type(num)
    rescue RuntimeError => e
      puts e.message
      retry
    end
  end

  def create_route #3
    a_station = create_first_station
    b_station = create_final_station(a_station)
    all_routes << Route.new(a_station, b_station)
    puts
    all_routes_numbered #удалить?
  end

  def add_station_to_route #4
    if all_routes.empty?
      puts "There is no routes to choose."
    else
      current_route = choose_route
      current_station = create_choose_station
      current_route.add_station(current_station)
      puts "Updated route: #{current_route.stations.map(&:name)}" #удалить?
    end
  end

  def delete_station_from_route #5
    if all_routes.empty?
      puts "There is no routes to choose." #удалить?
    else
      current_route = choose_route
        if current_route.stations.count <= 2
          puts "It can't be less then 2 stations in route. Nothing to delete"
        else
          current_station = choose_station
          current_route.remove_station(current_station)
          puts "Updated route: #{current_route.stations.map(&:name)}"
        end
    end
  end

  def assign_route_to_train #6
    if all_trains.empty?
      puts "There is no trains. Create new."
    elsif
      all_routes.empty?
      puts "There is no routes to assign."
    else
      current_train = choose_train
      current_route = choose_route
      current_train.accept_route(current_route)
      current_train.current_station.arrive(current_train)
    end
  end
    
  #7 Add wagons to train
  def add_wagons_to_train
    current_train = choose_train
      if current_train.nil?
        puts "Create train at first."
      else
        puts "Quantity of wagons: "
        num = gets.chomp.to_i
        num.times {current_train.add_wagon}
        current_train.show_info
      end
  end

  #8 Delete wagons from train
  def delete_wagons_from_train
    current_train = choose_train
      if current_train.nil?
        puts "Create train at first."
      else
        current_train.show_info
        puts "Quantity of wagons to delete: "
        num = gets.chomp.to_i
          if current_train.train_wagons.empty?
            puts "There is no wagons in this train."
          elsif
            current_train.train_wagons.count < num
            puts "There is no that much wagons in this train."
          else            
            num.times {current_train.delete_wagon}
            current_train.show_info
          end
      end
  end

  #9 Move train by route
  def move_train
    current_train = choose_train 
      if current_train.route.nil?
        current_route = choose_route
        current_train.accept_route(current_route)
        current_train.current_station.arrive(current_train)      
      else
        current_route = current_train.show_current_station_and_route
      end 
    puts "1 - move forvard"
    puts "2 — move backward"
    choice = gets.chomp.to_i
      if choice == 1                
        current_train.current_station.depart(current_train)
        current_train.go_next_station  
        current_train.current_station.arrive(current_train) 
        puts "Current station «#{current_train.current_station.name}»"    
      elsif choice == 2
        current_train.current_station.depart(current_train)
        current_train.go_previous_station
        current_train.current_station.depart(current_train)
        puts "Current station «#{current_train.current_station.name}»"    
      end
    puts "Create train and route before." if current_train.nil? && current_route.nil?
  end

  #10 Show routs list
  def show_routs_list
    all_routes_numbered
  end

  #11 Show stations list
  def show_stations_list
    all_stations_numbered
    Station.all
  end

  #12 Show trains list
  def show_trains_list
    all_trains_numbered
  end

  #13 Add/show manufactorer
  def add_show_manufactorer
    choice = choose_add_or_show_manufactorer
    if choice == 1 #добавляем производителя
      current_train = choose_train
        if current_train.nil?
          puts "You need an object to assign manufactorer."
        else
          current_train.add_manuf
        end
    elsif choice == 2 #показываем производителя
      if current_train.nil?
        puts "There is nothing to show."
      else
        current_train = choose_train
        current_train.show_manuf
      end
    else
      puts "Choose 1 or 2."
      type = select_train_or_wagon
    end
  end

  def train_info #14
    train = choose_train
    train.show_info
  end
  
  def find_train #15
     if all_trains.empty?
      puts "There is no any trains."
     else
      print "Enter train's number: "
      num = gets.chomp
      Train.find(num)
     end
  end
  
  # Дополнительные методы
  def all_trains_numbered
    if all_trains.empty?
      puts "There is no any trains."
    else
      all_trains.each.with_index(1) {|train, i| puts "#{i}. Train №#{train.number} — #{train.type}, wagons: #{train.train_wagons.count}"}
    end
  end

  def all_stations_numbered
    if all_stations.empty?
      puts "There is no any stations."
    else
      all_stations.each.with_index(1) {|station, i| puts "#{i}. #{station.name}: #{station.trains.map(&:number)} - #{station.trains.map(&:type)}"} 
    end
  end

  def route_stations_numbered
    current_route.each.with_index(1) {|station, i| puts "#{i}. #{station.name}: #{station.trains.map(&:number)} - #{station.trains.map(&:type)}"} 
    puts
  end

  def all_routes_numbered
    if all_routes.empty?
      puts "There is no any routs."
    else
      all_routes.each.with_index(1) {|route, i| puts "#{i}. Route: #{route.stations.map(&:name)}"}
    end
  end

  def choose_route     
    if all_routes.empty?
      puts "There is no routes."
    else
      all_routes_numbered
      print "Choose route: "
      all_routes[gets.chomp.to_i-1]            
    end
  end

  def choose_station_from_current_route
    route_stations_numbered
    print "Choose station: "
    current.route[gets.chomp.to_i-1]
  end

  def create_choose_station
    if all_stations.empty?
      create_station 
    else
      puts "0. Create new sation"
      all_stations_numbered
      print "Choose: "
      s = gets.chomp.to_i
      create_station if s == 0 
      all_stations[s-1]
    end
  end
    
  def choose_station
    if all_stations.empty?
      puts "There is no station in list."
    else
      all_stations_numbered
      print "Choose station: "
      all_stations[gets.chomp.to_i-1]
    end
  end
    
  def choose_train
      all_trains_numbered
      t = gets.chomp.to_i
      all_trains[t-1]
  end

  def add_station
    print "Enter station's name: " 
    station = Station.new(gets.chomp.to_s.capitalize)
    all_stations << station
    station
  end

  def create_first_station
    puts "First station."
      if all_stations.count == 0
        a_station = add_station
      else
        a_station = create_choose_station
      end
    puts "Station #{a_station.name} selected."
    a_station
  end

  def create_final_station(a_station)
    puts "Final station."
      if all_stations.count == 1
        b_station = add_station
      else
        b_station = create_choose_station
          while a_station == b_station
            puts "Stations should be different."
            b_station = create_final_station(a_station)
          end
      end
    puts "Station /#{b_station.name}/ selected."
    b_station
  end

  def enter_station_name
    print "Enter station's name: "
    name = gets.chomp.to_s.capitalize
      while all_stations.map(&:name).include?(name)
        print "This station already exist. Enter station's name: "
        name = gets.chomp.to_s.capitalize
      end
    name
  end

  def choose_add_or_show_manufactorer
    puts "1 — add manufactorer"
    puts "2 — show manufactorer"
    print "You choice: "
    choice = gets.chomp.to_i
  end

  def create_train_num
    print "Enter train's number [ЧЧЧ-ББ]: "
    num = gets.chomp.to_s.capitalize
      while all_trains.map(&:number).include?(num)
        puts "This train already exist."
        print "Enter train's number [ЧЧЧ-ББ]: "
        num = gets.chomp.to_s.capitalize
      end
    num
  end

  def select_train_type
    print "Choose type (cargo - 1, passenger - 2): "
    type = gets.chomp.to_i
      while type != 1 && type != 2
        print "Choose 1 or 2: (cargo - 1, passenger - 2): "
        type = gets.chomp.to_i
      end
    type
  end

  def create_train_by_type(num)
    type = select_train_type
    if type == 1
      all_trains << CargoTrain.new(num)
      puts "Cargo train №#{num} created."
    else type == 2
      all_trains << PassengerTrain.new(num)
      puts "Passenger train №#{num} created."
    end
  end

  def valid?
    validate!
      true # возвращаем true, если метод validate! не выбросил исключение
    rescue
      false # возвращаем false, если было исключение
  end
end

railroad = RailRoad.new
railroad.start