class Person
  attr_reader :name, :banks
  attr_accessor :cash

  def initialize(name, cash)
    @name = name
    @cash = cash.negative? ? 0 : cash
    @banks = {}
    creation_msg
  end

  def creation_msg
    "#{name} has been created with #{cash} galleons in cash."
  end

  def add_bank(bank)
    banks[bank.bank_name] = { balance: 0 }
  end
end
