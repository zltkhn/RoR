require_relative './route.rb'
require_relative './station.rb'
require_relative './train.rb'
require_relative './wagons.rb'
require_relative './cargo_train.rb'
require_relative './passenger_train.rb'
require_relative './cargo_wagon.rb'
require_relative './passenger_wagon.rb'


puts "-----"
w1 = CargoWagon.new
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