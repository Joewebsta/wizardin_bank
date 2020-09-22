class Bank
  attr_reader :bank_name
  attr_accessor :person

  def initialize(bank_name)
    @bank_name = bank_name
    @person = nil
    creation_msg
  end

  def creation_msg
    "#{bank_name} has been created."
  end

  def open_account(customer)
    self.person = customer

    "An account has been opened for #{customer.name} with #{bank_name}."
  end
end
