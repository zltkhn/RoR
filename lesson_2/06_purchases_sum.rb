
puts "Для завершения напишите «стоп» в поле «Товар»."
item = nil
items = Hash.new
total = []
loop do
    print "\nТовар: "
    item = gets.chomp.to_s
    #items["Товар"] = item

  break if item == "стоп" 
 
    print "Количество: "
    quantity = gets.chomp.to_f

    print "Цена (руб.): "
    price = gets.chomp.to_f 
 
   items[item] = {:quantity => quantity, :price => price, :sum => quantity*price }
   total << items[item][:sum]
end

items.delete("стоп")

if items != 0
  puts "\nКорзина:" 
else
  puts "\nКорзина пуста"
end

items.each do |item, prices|
    puts "#{item}: #{prices}"
end

final = 0
total.each {|sum| final += sum }

puts  "Всего товаров на сумму: #{final} руб."