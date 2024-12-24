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
  attr_accessor :instances

  def register_instance
    self.class.instances =+ 1
  end
end