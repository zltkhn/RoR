module Manufactorer

  def add_manufactorer
    print "Add manufactorer: "
    self.manufactorer = gets.chomp.to_s.capitalize
  end

  def show_manufactorer
    if manufactorer.nil?
      puts "Manufactorer not added."
    else
      puts "Manufactorer: /#{self.manufactorer}/."
    end
  end

  protected
  attr_accessor :manufactorer
end