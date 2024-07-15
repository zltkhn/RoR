



# CТАНЦИЯ
class Station
    attr_accessor :trains_amount

    def initialize(name)
        @name = name
        @trains_amount = 0
        @trains_on_station =[]
    end

# Поезда на станции
    def trains_on_station
        puts "На станции #{@name} находится  поезда: #{@trains_on_station} в количестве: #{@trains_amount}."
    end

# Поезда на станции по типу
    def trains_on_station_by_type
        puts "Сейчас на станции грузовых: #{@trains_on_station} и пассажирских: "
    end

# Добавляем поезд
    def add_a_train (train)
        number = train
        @trains_on_station << @number
        @trains_amount += 1
        puts "Прибыл #{@type} поезд №#{@number}"
        
    end

# Отправляем поезд
    def depart
        @trains_amount -= 1
        puts "Отправился 1 поезд"
    end
end

# МАРШРУТ
class Route
    def initialize(a_station, b_station)
        @a_station = a_station
        @b_station = b_station
        @route = [@a_station, @b_station]
    
    end

# Удаляем станцию по названию
    def add_station(name_of_station)
        @route.delete(@b_station)
        @route << name_of_station
        @route << @b_station
        puts "В маршрут добавлена станция #{name_of_station}."
    end

# Удаляем станцию по названию
    def remove_station(name_of_station)
        if @route.include?(name_of_station) 
            @route.delete(name_of_station)
            puts "Из маршрута удалена станция #{name_of_station}." 
        else
            puts "Станции #{name_of_station} нет в маршруте."
        end
    end
# Показываем маршрут
    def stations_list
       puts "Маршрут: #{@route}"
    end
end

# ПОЕЗД
class Train  < Route

    def initialize(number = 001, type = пассажирский, wagons = 20)
        @number = number.to_s
        @type = type.to_s
        @wagons = wagons.to_i
        @speed = 0
    end

# Информация о поезде
    def show_train
        puts "Поезд №#{@number}, #{@type}, вагонов: #{@wagons}"
    end

# Тип поезда
    def train_type
        puts "Поезд №#{@number} #{@type}"
    end

# Количество вагонов
    def wagons
        puts "В поезде №#{@number} вагонов: #{@wagons}"
    end

# Текущая скорость
    def current_spead
        puts "Текущая скорость поезда №#{@number}: #{@speed} км/ч"
    end

# Скорость +
    def speed_up(speed)
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
        puts "Поезд №#{@number} остановился"
    end

# Прицепить вагон
    def wagon_add
        if @speed == 0
            @wagons += 1
            puts "Поезд №#{@number}: прицеплен 1 вагон"
        else
            puts "Нельзя прицепить вагон к поезду №#{@number} на ходу"
        end
    end
 
# Отцепить вагон   
    def wagon_sub
        if @speed == 0
            @wagons -= 1
            puts "Отцеплен 1 вагон"
        else
            puts "Нельзя отцепить вагон на ходу"
        end
    end
end


puts "-----"
train1 = Train.new(123, "грузовой", 50)
train1.show_train
train2 = Train.new(076, "пассажирский", 17)
train2.show_train
2.times {train1.speed_up(40)}
train1.stop
train1.current_spead
2.times {train2.wagon_add}
train1.speed_up(200)
train1.current_spead
train1.wagon_sub
train1.wagons
train2.wagons
train2.wagon_sub
train1.train_type
train2.train_type

puts "-----"

station1 = Station.new("Таватуй")
station1.trains_on_station
station1.add_a_train(train1)
station1.depart
station1.trains_on_station
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
station1.trains_on_station_by_type

