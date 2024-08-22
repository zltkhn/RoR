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