require_relative './route.rb'
require_relative './station.rb'
require_relative './train.rb'
require_relative './wagons.rb'
require_relative './cargo_train.rb'
require_relative './passenger_train.rb'
require_relative './cargo_wagon.rb'
require_relative './passenger_wagon.rb'

class RailRoad
    attr_reader :all_routes, :all_stations, :all_trains, :all_wagons, :action
    
    def initialize
        @all_routes = []
        @all_stations = %w[]
        @all_trains = []
        @all_wagons = []
    end

    def start
        loop do
            menu
            action = gets.chomp.to_i
            puts
            choose(action)
        break if action == 0
        end
    end
    
    private #меню не используется нигде, кроме как на старте

    def menu
        puts "====="
        puts " 1 - Create station"
        puts " 2 - Create train"
        puts " 3 - Create route"
        puts " 4 - Add station to route"
        puts " 5 - Delete station from route" 
        puts " 6 - Assign route to train"
        puts " 7 - Add wagons to train"
        puts " 8 - Delete wagons from train"
        puts " 9 - Move tain forward"
        puts "10 - Move tain back"
        puts "11 - Show routs  list"
        puts "12 - Show stations list"
        puts "0 - Exit"
        puts
        print "Сhoose option: "
    end
        
   
    def choose(action)
        case action
            when 1 then create_station
            when 2 then create_train
            when 3 then create_route
            when 4 then add_station_to_route
            when 5 then delete_station_from_route
            when 6 then assign_route_to_train
            when 7 then create_station
            when 8 then create_station
            when 9 then create_station
            when 10 then create_station
            when 11 then show_routs_list
            when 12 then show_stations_list
            when 0 then exit
        else
            puts "There is no such an action. Please choose one of the following: \n"
            puts
        end
    end

    # 1
    def create_station
        print "Enter station's name: "
        name = gets.chomp.to_s.capitalize
         if all_stations.map(&:name).include?(name)
            puts "This station already exist."
         elsif
            all_stations << Station.new(name)
            puts "Station #{name} was created."
            #all_stations.each_with_index {|station, i| puts "#{i+1}. #{station.name}"}
            puts
         end
    end

    #2
    def create_train
        print "Enter train number: "
        num = gets.chomp.to_s
        while all_trains.map(&:number).include?(num)
            puts "This train already exist."
            print "Enter train number: "
            num = gets.chomp.to_s
        end
        print "Choose type (cargo - 1, passenger - 2): "
        type = gets.chomp.to_i
            if type == 1
                all_trains << CargoTrain.new(num)
            elsif type == 2
                all_trains << PassengerTrain.new(num)
            else 
                puts "There is no such train type. Please choose 1 or 2"
            end
        puts "Train №#{num} created."
        all_trains_list_numbered_with_type
    end

    #3
    def create_route
        print "Enter start station: "
        a_station = gets.chomp.to_s.capitalize 
        print "Enter final station: "
        b_station = gets.chomp.to_s.capitalize
        while a_station == b_station
            puts "Stations shoud be different."
            print "Enter final station: "
            b_station = gets.chomp.to_s.capitalize
        end
        all_routes << Route.new(a_station, b_station)
        all_stations << Station.new(a_station)
        all_stations << Station.new(b_station)
        all_routes_numbered    
    end

    #4
    def add_station_to_route
        if all_routes.empty?
            puts "There is no routes to choose."
        else
            puts "Choose route:"
            all_routes_numbered
            puts
            print "Choose the route: "
            r = gets.chomp.to_i
            puts
            puts "Choose station:"
            puts "0. Create new sation"
            all_stations_numbered
            print "Choose the station: "
            s = gets.chomp.to_i
            create_station if s == 0 
            current_route = all_routes[r-1]
            current_station = all_stations[s-1]
            current_route.add_station(current_station.name)
            puts "Updated route: #{current_route.stations_list}"
        end
    end

    #5
    def delete_station_from_route
        if all_routes.empty?
            puts "There is no routes to choose."
        else
            puts "Choose route:"
            all_routes_numbered
            puts
            print "Choose the route: "
            r = gets.chomp.to_i
            current_route = all_routes[r-1]
            if current_route.stations.count <= 2
                puts "It can't be less then 2 stations in route. Nothing to delete"
            else
                puts "Choose station:"
                current_route.stations.each.with_index(1) {|station, i| puts "#{i}. #{station}"} 
                print "Choose the station: "
                s = gets.chomp.to_i
                
                current_station = all_stations[s-1]
                current_route.remove_station(current_station.name)
                puts "Updated route: #{current_route.stations_list}"
            end
        end
    end

    #6
    def assign_route_to_train
        if all_trains.empty?
            puts "There is no trains."
        elsif
            all_routes.empty?
            puts "There is no routes to assign."
        else
            puts "Choose train: "   
            all_trains_list_numbered
            t = gets.chomp.to_i
            current_train = all_trains[t-1]
            
            puts "Choose route: "
            all_routes_numbered
            print "Choose the route: "
            r = gets.chomp.to_i
            current_route = all_routes[r-1]
            current_train.accept_route(current_route)
        end
    end

    #7

    #8

    #9

    #10

    #11
    def show_routs_list
        if all_routes.empty?
            puts "There is no any routs."
        else
            all_routes.each_with_index {|route, i| puts "#{i+1}. #{route.stations}"}
        end
    end

    #12
    def show_stations_list
        if all_stations.empty?
            puts "There is no any stations."
        else
            all_stations.each_with_index {|station, i| puts "#{i+1}. #{station.name}"}
        end
    end

private

    def all_trains_list_numbered
        all_trains.each.with_index(1) {|train, i| puts "#{i}. Train №#{train.number}"}
        puts
    end

    def all_trains_list_numbered_with_type
    all_trains.each.with_index(1) {|train, i| puts "#{i}. Train №#{train.number} — #{train.type}"}
    puts
    end

    def all_stations_numbered
        all_stations.each.with_index(1) {|station, i| puts "#{i}. #{station.name}"} 
        puts
    end

    def all_routes_numbered
        all_routes.each.with_index(1) {|route, i| puts "#{i}. Route: #{route.stations}"}
    puts
    end

end


railroad = RailRoad.new
railroad.start

=begin
action = gets.chomp.downcase.to_s

puts "-----"
w1 = CargoWagon.new("cargo")
train1 = Train.new("Н123", "cargo")
train1.show_info
train2 = Train.new("А076", "passenger")
train2.show_info
train3 = Train.new("А999", "cargo")
train3.show_info
train4 = Train.new("9837", "passenger")
train4.show_info
puts "-----"
train1.speed_up(40)
train1.stop
train1.current_speed
train2.add_wagon(w1)
train1.speed_up (200)
train1.speed_down (20)
train1.current_speed
train1.add_wagon("cargo")

puts "-----"
station1 = Station.new("Таватуй")
station1.trains_on_station_count
station1.arrive(train1)
station1.arrive(train2)
station1.arrive(train3)
station1.arrive(train4)
station1.depart(train1)
station1.trains_on_station_count
station1.trains_list
puts "-----"
route1 = Route.new("Cан-Донато", "Гать")
route1.stations_list
route1.add_station("Аять")
route1.add_station("Таватуй")
route1.add_station("Невьянск")
route1.remove_station("Невьянск")
route1.remove_station("Уфа")
route1.stations_list
puts "-----"
station1.trains_by_types
puts "-----"
train1.accept_route(route1)
train1.go_next_station
train1.go_next_station
train1.go_next_station
train1.go_next_station
train1.go_next_station
train2.substract_wagon
train1.location
station1.trains_list

puts "ВАГОНЫ"

train1.add_wagon(w1)
train1.show_info

puts "=====FINAL====="
=end