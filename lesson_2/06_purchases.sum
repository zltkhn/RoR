
puts "Для завершения напишите «стоп» в поле «Товар»."
item = nil
items = []
if_empty = "Поле не может быть пустым"

loop do
    print "\nТовар: "
    item = gets.chomp.to_s
    items << item

  break if item == "стоп" 

    print "Количество: "
    quantity = gets.chomp.to_f

    print "Цена (руб.): "
    price = gets.chomp.to_f  

end
puts "\Корзина:" 

items.delete("стоп")
puts items
busket = Hash.new
busket 