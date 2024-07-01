# ВВОДНЫЕ ДАННЫЕ
print "День: "
dd = gets.chomp.to_i
if dd > 31 || dd < 1
    puts "!!! В месяце от 1 до 31 дня."
    puts "День: "
    dd = gets.chomp
end

print "Месяц: "
mm = gets.chomp.to_i
if mm > 12 || mm < 1
    puts "!!! В году от 1 до 12 месяцев."
    puts "Месяц: "
    mm = gets.chomp.to_i
end

print "Год: "
yy = gets.chomp.to_i
if yy < 1
    puts "!!! Можем посчитать минимум с 1 года."
    puts "Год: "
    yy = gets.chomp.to_i
end

# ОПРЕДЕЛЯЕМ ГОД (ВИСОКОСНЫЙ)
leap = 366
non_leap = 365

if yy % 4 == 0
    if yy % 100 ==0 
        if yy % 400 ==0
            yy = leap
        else 
            yy = non_leap
        end
    else yy = leap
    end
else yy = non_leap
end

print "Количество дней: #{yy}, " 
if yy == non_leap
    puts "не високосный год."
else
    puts "високосный год."
end

# Меняем февраль в зависимости от високосного года
months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
if yy == leap
    months[1] = 29
end

# СЧИТАЕМ ПОРЯДОК ОТ НАЧАЛА ГОДА
n = 0 #номер в массиве
while n < mm do
        if n<1 
            sum = 0
        else
            sum = months[0..n-1].sum
        end
    n += 1  
end
puts "Порядковый номер даты с начала года: #{sum+dd} день"