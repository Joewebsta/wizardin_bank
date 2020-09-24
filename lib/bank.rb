class Bank
  attr_reader :bank_name
  attr_accessor :customers

  def initialize(bank_name)
    @bank_name = bank_name
    @customers = {}
    creation_msg
  end

  def creation_msg
    "#{bank_name} has been created."
  end

  def open_account(customer)
    customers[customer.name] = { balance: 0 }
    customer.add_bank(bank_name)
    "An account has been opened for #{customer.name} with #{bank_name}."
  end

  def deposit(customer, amt)
    if amt > customer.cash
      "#{customer.name} does not have enough cash to perform this deposit."
    else
      customers[customer.name][:balance] += amt
      customer.banks[bank_name][:balance] += amt
      customer.cash -= amt

      bank_bal = customer.banks[bank_name][:balance]
      "#{amt} galleons have been deposited into #{customer.name}'s' #{bank_name} account. Balance: #{bank_bal} Cash: #{customer.cash}."
    end
  end
end
