#Массив с числами 1-100 с шагом 5

range = (10..100)
arr = []
range.each do |num|
    if num % 5 == 0
    arr << num
    end
end
puts arr