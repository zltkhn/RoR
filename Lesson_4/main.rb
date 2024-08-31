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
        @all_stations = []
        @all_trains = []
    end

    def start
        loop do
            menu
            action = gets.chomp.to_i
            puts
            choose(action)
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
        puts "0 - Exit"
        puts
        print "Сhoose an option: "
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
            when 0 then exit
        else
            puts "There is no such an action. Please choose one of the following: "
            puts
            #добавить проверку если значние текст
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
            puts "Train №#{num} created."
        elsif type == 2
            all_trains << PassengerTrain.new(num)
            puts "Train №#{num} created."
        else
            print "Please repeat and select type 1 or 2."
        end
        all_trains_numbered_with_type
    end

    #3
    def create_route
        puts "First station."
        if all_stations.empty?
            print "Enter station's name: " 
            a_station = Station.new(gets.chomp.to_s.capitalize)
        else
            puts "0. Create new sation"
            all_stations_numbered
            print "Choose: "
            s = gets.chomp.to_i
            if s == 0 
                print "Enter station's name: " 
                a_station = Station.new(gets.chomp.to_s.capitalize)
            end
            all_stations[s-1]
        end
        all_stations << a_station
        puts
        puts "Final station."
        b_station = create_choose_station
        while a_station == b_station
            puts "Stations shoud be different."
            b_station = create_choose_station
        end
        
        all_routes << Route.new(a_station, b_station)
        all_routes_numbered    
    end

    #4
    def add_station_to_route
        if all_routes.empty?
            puts "There is no routes to choose."
        else
            current_route = choose_route
            current_station = create_choose_station
            current_route.add_station(current_station)
            puts "Updated route: #{current_route.stations.map(&:name)}"
        
        end
    end

    #5
    def delete_station_from_route
        if all_routes.empty?
            puts "There is no routes to choose."
        else
            current_route = choose_route
            if current_route.stations.count <= 2
                puts "It can't be less then 2 stations in route. Nothing to delete"
            else
                current_station = choose_station
                current_route.remove_station(current_station.name)
                puts "Updated route: #{current_route.stations_list}"
            end
        end
    end

    #6
    def assign_route_to_train
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
    
    #7
    def add_wagons_to_train
        current_train = choose_train
        if current_train == nil
             puts "Create train at first."
        else
            puts "Quantity of wagons: "
            num = gets.chomp.to_i
            num.times {current_train.add_wagon}
            current_train.show_info
        end
    end

    #8
    def delete_wagons_from_train
        current_train = choose_train
        if current_train == nil
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
                #all_wagons.map{|wagon| wagon.type == :passenger}
             end
        end
    end

    #9
    def move_train
        current_train = choose_train
        current_route = choose_route
        if current_train != nil && current_route != nil
            current_train.accept_route(current_route)
            current_train.current_station.arrive(current_train)
            puts "1 - move forvard"
            puts "2 — move backward"
            choice = gets.chomp.to_i
            current_train.go_next_station if choice == 1
            current_train.go_previous_station if choice == 2
        else
            "Create train and route before."
        end
    end

    #10
    def show_routs_list
        if all_routes.empty?
            puts "There is no any routs."
        else
            all_routes.each.with_index(1) {|route, i| puts "#{i}. #{route.stations.map(&:name)}"}
        end
    end

    #11
    def show_stations_list
        if all_stations.empty?
            puts "There is no any stations."
        else
            all_stations_numbered
        end
    end

    #12
    def show_trains_list
        if all_trains.empty?
            puts "There is no any trains."
        else
            all_trains_numbered_with_type
        end
    end

    #Вспомогательные методы

    def all_trains_numbered
        all_trains.each.with_index(1) {|train, i| puts "#{i}. Train №#{train.number}"}
        puts
    end

    def all_trains_numbered_with_type
        all_trains.each.with_index(1) {|train, i| puts "#{i}. Train №#{train.number} — #{train.type}, wagons: #{train.train_wagons.count}"}
        puts
    end

    def all_stations_numbered
        all_stations.each.with_index(1) {|station, i| puts "#{i}. #{station.name}: #{station.trains.map(&:number)} - #{station.trains.map(&:type)}"} 
        puts
    end

    def all_routes_numbered
        all_routes.each.with_index(1) {|route, i| puts "#{i}. Route: #{route.stations.map(&:name)}"}
        puts
    end
    
    def all_wagons_by_type
        #all_wagons.each.with_index(1) {|w, i| puts "#{i}. wagon: #{w}"}
        puts "Cargo wagons: #{all_wagons.select{|wagon| wagon.type == :cargo}.count}" 
        puts "Passenger wagons: #{all_wagons.select{|wagon| wagon.type == :passenger}.count}" 
    end

    def choose_route     
        if all_routes.empty?
            puts "There is no routes."
        else
            all_routes_numbered
            print "Choose: "
            r = gets.chomp.to_i
            all_routes[r-1]            
        end
    end

    def choose_station
        if all_stations.empty?
            puts "There is no station in list."
        else
            puts "Choose station:"
            all_stations_numbered
            print "Choose: "
            s = gets.chomp.to_i
            all_stations[s-1]
        end
    end

    def create_choose_station
        if all_stations.empty?
            puts "There is no station in list."
            create_station
        else
            puts "Create or choose station:"
            puts
            puts "0. Create new sation"
            all_stations_numbered
            print "Choose: "
            s = gets.chomp.to_i
            create_station if s == 0 
            all_stations[s-1]
        end
    end

    def choose_train
        if all_trains.empty?
            puts "There is no trains"
        else
            print "Choose train: "   
            all_trains_numbered
            t = gets.chomp.to_i
            all_trains[t-1]
        end
    end

end

railroad = RailRoad.new
railroad.start


