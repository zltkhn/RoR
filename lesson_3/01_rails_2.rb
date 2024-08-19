class Route
    attr_reader :stations

    def initialize(a_station, b_station)
        @stations = [a_station, b_station]
    end

    def add_station(station)
        stations.insert(-2, station)
    end

    def remove_station(station)
        stations.delete(station) if stations.include?(station) 
    end

    def stations_list
       stations
    end
end

class Train
    attr_reader :type, :number, :wagons_count, :speed
    
    def initialize(number, type, wagons_count)
        @number = number
        @type = type
        @wagons_count = wagons_count.to_i
        @speed = 0
    end

    def show_info
        puts "Поезд №#{number} — #{type}, вагонов: #{wagons_count}"
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

    def wagon_add
        @wagons_count += 1 if speed == 0
    end
 
    def wagon_sub
        @wagons_count -= 1 if @wagons_count >= 0 && @speed == 0
    end

    def accept_route(route)
        @route = route
        @position = 0
        puts "Поезд #{number} следует по маршруту: #{route.stations}"
        puts "Начальная станция: «#{current_station}»"
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
        #@position += 1 until next_station
        @position += 1 if next_station
    end

    def go_previous_station
        @position -= 1 if previous_station
    end

    def location
        puts "Текущая станция «#{current_station}»."
        puts "Предыдущая станция «#{previous_station}»."
        puts "Следующая станция «#{next_station}»."
    end
end

class Station 
    attr_reader :name, :trains

    def initialize(name)
        @name = name
        @trains = []
    end

    def trains_on_station_count
        if @trains.empty?
            puts "На станции «#{name}» нет поездов."
        else
            puts "На станции «#{name}» находится поездов: #{trains.count}."
        end
    end

    def trains_list
        puts "Список поездов: #{trains}"
    end

    def trains_by_types
        trains_pass = trains.select {|t| t.type == "пассажирский"}
        trains_cargo = trains.select {|t| t.type == "грузовой"}
        puts "Пассажирскийх поездов: #{trains_pass.count}"
        puts "Грузовых поездов: #{trains_cargo.count}"
        puts "Всего поездов: #{trains.count}"
    end

    def arrive(train)
        trains << train
    end

    def depart(train)
        trains.delete(train)
    end
end


puts "-----"
train1 = Train.new("Н123", "грузовой", 50)
train1.show_info
train2 = Train.new("А076", "пассажирский", 17)
train2.show_info
train3 = Train.new("А999", "грузовой", 1)
train3.show_info
train4 = Train.new("9837", "пассажирский", 10)
train4.show_info
puts "-----"
train1.speed_up(40)
train1.stop
train1.current_speed
train2.wagon_add
train1.speed_up (200)
train1.speed_down (20)
train1.current_speed
train1.wagon_sub
train1.wagons_count
train2.wagons_count
train2.wagon_sub

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
train1.location
puts "=====FINAL====="