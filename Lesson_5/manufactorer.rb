module Manufactorer

  def add_manufactorer
    print "Type manufactorer: "
    self.manufactorer = gets.chomp.to_s.capitalize
    puts "Manufactorer /#{self.manufactorer}/ added."
  end

  def show_manufactorer#(manufactorer)
    if manufactorer.nil?
      puts "Manufactorer not added."
    else
      puts "Manufactorer: /#{self.manufactorer}/."
    end
  end

  protected
  attr_accessor :manufactorer
end