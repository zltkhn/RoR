#Числа фибоначчи до 100

arr = [0, 1]
a = 1
b = arr[-2]
f = a+b
while f < 100 do
    arr << f
    a = arr.last
    b = arr[-2]
    f = a+b
end
puts arr    