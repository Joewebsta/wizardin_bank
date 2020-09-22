class Bank
  attr_reader :name, :person

  def initialize(name, person = nil)
    @name = name
    @person = person
    creation_msg
  end

  def creation_msg
    "#{name} has been created."
  end
end
