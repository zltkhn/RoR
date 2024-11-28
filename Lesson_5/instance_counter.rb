module InstanceCounter

  module ClassMethods
    def initialize
      @instances ||= 0
    end
  end

  def instances
    self.instances
  end

  protected
  def register_instance
    self.class.instances =+ 1
  end

  attr_accessor :instances
end