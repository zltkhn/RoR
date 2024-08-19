require_relative './01_rails_class_route.rb'
require_relative './01_rails_class_station.rb'
require_relative './01_rails_class_train.rb'


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