class Train
    attr_reader :type, :number, :wagons, :speed
    
    def initialize(number, type)
        @number = number
        @type = type
        @speed = 0
        @wagons = []
    end

    def show_info
        puts "Train №#{number} — #{type}, wagons: #{wagons}"
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

    def add_wagon(wagon)
        @wagons << wagon
    end
 
    def substract_wagon
        @wagons.delete = wagon if @wagons.empty? && @speed.zero?
    end

    def accept_route(route)
        @route = route
        @position = 0
        puts "Train #{number} follows the route: #{route.stations}"
        puts "Start: «#{current_station}»"
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
        puts "Current station «#{current_station}»."
        puts "Previous station «#{previous_station}»."
        puts "Next station «#{next_station}»."
    end
end