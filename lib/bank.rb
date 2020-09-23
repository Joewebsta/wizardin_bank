class Bank
  attr_reader :bank_name
  attr_accessor :customers

  def initialize(bank_name)
    @bank_name = bank_name
    @customers = []
    creation_msg
  end

  def creation_msg
    "#{bank_name} has been created."
  end

  def open_account(customer)
    customers <<  { customer.name => { balance: 0 } }
    customer.add_bank(bank_name)
    "An account has been opened for #{customer.name} with #{bank_name}."
  end
end
