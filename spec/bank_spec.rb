require './lib/bank'
require './lib/person'

describe Bank do
  subject { Bank.new('JP Morgan Chase') }

  describe '#init' do
    it 'has a name' do
      expect(subject.bank_name).to eql('JP Morgan Chase')
    end

    it 'does not have a person by default' do
      expect(subject.person).to be_nil
    end
  end

  describe '#creation_msg' do
    it 'displays a creation message' do
      expect(subject.creation_msg).to eql('JP Morgan Chase has been created.')
    end
  end

  describe '#open_account' do
    let(:person1) { Person.new('Joe', 1000) }

    it 'adds a person to the bank' do
      subject.open_account(person1)
      expect(subject.person).to eql(person1)
    end

    it 'displays an account creation message' do
      expect(subject.open_account(person1)).to eql('An account has been opened for Joe with JP Morgan Chase.')
    end
  end
end
