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
    return 'Please provide a valid deposit amount.' if amt.negative?
    return "#{customer.name} does not have enough cash to perform this deposit." if amt > customer.cash

    customers[customer.name][:balance] += amt
    customer.banks[bank_name][:balance] += amt
    customer.cash -= amt

    bank_bal = customer.banks[bank_name][:balance]
    "#{amt} galleons have been deposited into #{customer.name}'s' #{bank_name} account. Balance: #{bank_bal} Cash: #{customer.cash}."
  end

  def withdrawal(customer, amt)
    customer_bank_bal = customers[customer.name][:balance]
    return 'Please provide a valid withdrawal amount.' if amt.negative?
    return 'Insufficient funds.' if amt > customer_bank_bal

    customers[customer.name][:balance] -= amt
    customer.banks[bank_name][:balance] -= amt
    customer.cash += amt

    bank_bal = customer.banks[bank_name][:balance]
    "#{customer.name} has withdrawn #{amt} galleons. Balance: #{bank_bal}."
  end

  def transfer(customer, bank, amt)
    customer_bank_bal = customers[customer.name][:balance]
    return 'Please provide a valid transfer amount.' if amt.negative?
    return 'Insufficient funds.' if amt > customer_bank_bal
    return "#{customer.name} does not have an account with #{bank.bank_name}." if bank.customers[customer.name].nil?

    customers[customer.name][:balance] -= amt
    bank.customers[customer.name][:balance] += amt

    "#{customer.name} has transferred #{amt} galleons from #{bank_name} to #{bank.bank_name}."
  end
end
