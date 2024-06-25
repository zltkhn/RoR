print " Коэффициент a: "
a = gets.chomp.to_f
print "Коэффициент b: "
b = gets.chomp.to_f
print "Коэффициент c: "
c = gets.chomp.to_f
puts 
D = b**2 - 4*a*c
puts "Дискриминант: #{D}, корней нет." if D<0

if D > 0
  puts "Дискриминант: #{D}"
  puts "Корень x1: #{(-b - Math.sqrt(D))/(2*a)}"
  puts "Корень x2: #{(-b - Math.sqrt(D))/(2*a)}"
elsif D == 0
  puts "Дискриминант: #{D}"
  puts "Корень: #{(-b)/(2*a)}"

end