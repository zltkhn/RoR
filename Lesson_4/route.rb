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
        stations #.each.with_index(1) {|station, i| puts "#{i}. #{station.name}"}
    end
end