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