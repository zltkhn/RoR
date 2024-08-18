
# >>>>>>>>> МАРШРУТ
class Route
    attr_reader :route

    def initialize(a_station, b_station)
        @a_station = a_station
        @b_station = b_station
        @route = [@a_station, @b_station]
    end

# Добавляем станцию по названию
    def add_station(name_of_station)
        @route.insert(-2, name_of_station)
        puts "В маршрут добавлена станция «#{name_of_station}»."
    end

# Удаляем станцию по названию
    def remove_station(name_of_station)
        if @route.include?(name_of_station) 
            @route.delete(name_of_station)
            puts "Из маршрута удалена станция «#{name_of_station}»." 
        else
            puts "Станции «#{name_of_station}» нет в маршруте."
        end
    end

# Показываем маршрут
    def stations_list
       puts "Маршрут: #{@route}"
    end
end

# >>>>>>>>> ПОЕЗД
class Train < Route
    
    attr_reader :type, :number, :route_train
    attr_accessor :speed, :wagons, :position
    
    def initialize(number, type, wagons)
        @number = number
        @type = type
        @wagons = wagons
        @speed = 0
    end

# Информация о поезде
    def show_train
        puts "Поезд №#{number} — #{type}, вагонов: #{wagons}"
    end

# Тип поезда
    def train_type
        puts "Поезд №#{@number} — #{@type}"
    end

# Количество вагонов
    def wagons_count
        puts "В поезде №#{@number} вагонов: #{@wagons}"
    end

# Текущая скорость
    def current_spead
        puts "Текущая скорость поезда №#{@number}: #{@speed} км/ч"
    end

# Скорость +
    def speed_up (speed)
        @speed += speed
        puts "Скорость поезда №#{@number} увеличена на #{speed} км/ч"
    end

# Скорость -
    def speed_down(speed)
        @speed -= speed
        puts "Скорость поезда №#{@number} уменьшена на #{speed} км/ч"
    end

# Остановка
    def stop
        @speed = 0
        puts "Поезд №#{@number} остановился."
    end

# Прицепить вагон
    def wagon_add
        if @speed == 0
            @wagons += 1
            puts "Поезд №#{@number}: прицеплен 1 вагон"
        else
            puts "Нельзя прицепить вагон к поезду на ходу"
        end
    end
 
# Отцепить вагон   
    def wagon_sub
        if @wagons >= 0 || @speed == 0
            @wagons -= 1
            puts "От поезда №#{@number} отцеплен 1 вагон."
        else
            puts "Нельзя отцепить вагон на ходу"
        end
    end

# Принять маршрут   
    def accept_route(train_route)
        @train_route = train_route
        @position = 0
        puts "Поезд проследует по маршруту: #{@train_route.route}"
        puts "Начальная станция: «#{@train_route.route[@position]}»"
    end

    def next_station
        @train_route.route[@position +=1] 
        puts "Проехали 1 станцию вперед."
    end

    def previous_station
        @train_route.route[@position -=1] 
        puts "Вернулись на 1 станцию."
    end

    def location
        @train_route.route[@position] 
        puts "Текущая станция «#{@train_route.route[@position]}»."
        puts "Предыдущая станция «#{@train_route.route[@position -1]}»."
        puts "Следующая станция «#{@train_route.route[@position +1]}»."
    end

end

# >>>>>>>>> CТАНЦИЯ
class Station 

    def initialize(name)
        @name = name
        @trains_amount = 0
        @trains_list = {}
    end


# Поезда на станции (колчиество)
    def trains_on_station
        if @trains_amount == 0
            puts "На станции «#{@name}» нет поездов."
        else
            puts "На станции «#{@name}» находится поездов: #{@trains_amount}."
        end
    end

  # Поезда на станции (список)
    def show_trains_list
        puts "Список поездов:"
        @trains_list.each do |k, v|
            puts "№#{k}"
        end
    end

# Поезда на станции по типу
    def show_trains_list_types
        @trains_list.each do |k, v|
            puts "Поезд №#{k} — #{v}"
        end
    end

# Добавляем поезд
    def arrive(train)
        @trains_list[train.number] = {type:train.type}
        @trains_amount += 1
        puts "Прибыл #{train.type} поезд №#{train.number}"
    end

# Отправляем поезд
    def depart(train)
        @trains_list.delete(train.number)
        @trains_amount -= 1
        puts "Убыл 1 #{train.type} поезд №#{train.number}"
    end
end


puts "-----"
train1 = Train.new("Н123", "грузовой", 50)
train1.show_train
train2 = Train.new("А076", "пассажирский", 17)
train2.show_train
train3 = Train.new("А999", "грузовой", 1)
train3.show_train
train4 = Train.new("9837", "пассажирский", 10)
train4.show_train
2.times {train1.speed_up(40)}
train1.stop
train1.current_spead
5.times {train2.wagon_add}
train1.speed_up (200)
train1.speed_down (20)
train1.current_spead
train1.wagon_sub
train1.wagons_count
train2.wagons_count
train2.wagon_sub
train1.train_type
train2.train_type

puts "-----"
station1 = Station.new("Таватуй")
station1.trains_on_station
station1.arrive(train1)
station1.arrive(train2)
station1.arrive(train3)
station1.arrive(train4)
station1.depart(train1)
station1.trains_on_station
station1.show_trains_list
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
station1.show_trains_list_types
    puts "-----"
train1.accept_route(route1)
2.times {train1.next_station}
train1.previous_station
train1.location
puts "=====FINAL====="