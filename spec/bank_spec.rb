require './lib/bank'
require './lib/person'

describe Bank do
  subject { Bank.new('JP Morgan Chase') }
  let(:person1) { Person.new('Joe', 1000) }
  let(:person2) { Person.new('Skylar', 20) }

  describe '#init' do
    it 'has a name' do
      expect(subject.bank_name).to eql('JP Morgan Chase')
    end

    it 'does not have customers by default' do
      expect(subject.customers).to eql({})
    end
  end

  describe '#creation_msg' do
    it 'displays a creation message' do
      expect(subject.creation_msg).to eql('JP Morgan Chase has been created.')
    end
  end

  describe '#open_account' do
    it 'adds a person to the bank' do
      subject.open_account(person1)
      expect(subject.customers).to eql({ person1.name => { balance: 0 } })
    end

    it 'adds a second person to the bank' do
      subject.open_account(person1)
      subject.open_account(person2)
      expect(subject.customers).to eql({ person1.name => { balance: 0 }, person2.name => { balance: 0 } })
    end

    it "updates the person's bank hash" do
      subject.open_account(person1)
      expect(person1.banks).to eql({ 'JP Morgan Chase' => { balance: 0 } })
    end

    it 'displays an account creation message' do
      expect(subject.open_account(person1)).to eql('An account has been opened for Joe with JP Morgan Chase.')
    end
  end

  describe '#deposit' do
    context 'when customer cash exceeds depoit amt' do
      before do
        subject.open_account(person1)
        @message = subject.deposit(person1, 750)
      end

      it "increases the bank's balance." do
        bank_bal = subject.customers[person1.name][:balance]
        expect(bank_bal).to eql(750)
      end

      it "increases the person's bank balance" do
        customer_bal = person1.banks[subject.bank_name][:balance]
        expect(customer_bal).to eql(750)
      end

      it "decreases the person's cash amount" do
        expect(person1.cash).to eql(250)
      end

      it 'prints a deposit update message' do
        expect(@message).to eql("750 galleons have been deposited into Joe's' JP Morgan Chase account. Balance: 750 Cash: 250.")
      end
    end

    context 'when deposit amount exceeds customer cash ' do
      it 'prevents depositing more than available customer cash' do
        subject.open_account(person1)
        message = subject.deposit(person1, 5000)
        expect(message).to eql('Joe does not have enough cash to perform this deposit.')
      end
    end
  end

  describe '#withdrawal' do
    context 'when bank balance exceeds withdrawal amount' do
      before do
        subject.open_account(person1)
        subject.deposit(person1, 750)
        @message = subject.withdrawal(person1, 250)
      end

      it 'decreases the bank balance' do
        bank_bal = subject.customers[person1.name][:balance]
        expect(bank_bal).to eql(500)
      end

      it "decreases the person's bank balance" do
        customer_bal = person1.banks[subject.bank_name][:balance]
        expect(customer_bal).to eql(500)
      end

      it "increase the person's cash" do
        expect(person1.cash).to eql(500)
      end

      it 'prints a withdrawal message' do
        expect(@message).to eql('Joe has withdrawn 250 galleons. Balance: 500.')
      end
    end

    context 'when withdrawal amount exceeds bank balance' do
      before do
        subject.open_account(person1)
        subject.deposit(person1, 750)
        @message = subject.withdrawal(person1, 1000)
      end

      it 'does not change the bank balance' do
        bank_bal = subject.customers[person1.name][:balance]
        expect(bank_bal).to eql(750)
      end

      it "does not change the person's bank balance" do
        customer_bal = person1.banks[subject.bank_name][:balance]
        expect(customer_bal).to eql(750)
      end

      it "does not increase the person's cash" do
        expect(person1.cash).to eql(250)
      end

      it 'prints an insufficient funds message' do
        expect(@message).to eql('Insufficient funds.')
      end
    end
  end
end
