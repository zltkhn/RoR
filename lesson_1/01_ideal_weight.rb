puts "Как вас зовут?"
name = gets.chomp
puts "Какой у вас рост?"
height = gets.chomp.to_i
ideal_weight = (height-110)*1.15
if ideal_weight < 0
    puts "#{name}, ваш вес уже оптимальный!" 
else
    puts "#{name}, ваш идеальный вес #{ideal_weight}"
end