#Гласные с порядковым номером

letters1 = ('A'..'Z').to_a
a = 1
hash = Hash.new
letters1.each do |l|
    if l == "A" || l == "E"|| l == "I" || l == "O" || l == "U" || l == "Y" 
    hash[a] = l 
    end 
    a = a + 1  
end
hash.each do |number, letter|
    puts "#{letter} — #{number}"
end
puts "Всего в английском алфавите #{letters1.size} букв."   

letters2 = ('А'..'Я').to_a
a = 1
hash = Hash.new
letters2.each do |l|
    if l == "А" || l == "О"|| l == "У" || l == "Э" || l == "И" || l == "Ы" 
    hash[a] = l 
    end 
    a = a + 1  
end
hash.each do |number, letter|
    puts "#{letter} — #{number}"
end
puts "Всего в русском алфавите #{letters2.size} буквы."
