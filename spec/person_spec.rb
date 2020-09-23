require './lib/person'
require './lib/bank'

describe Person do
  subject { Person.new('Minerva', cash) }
  let(:cash) { 1000 }

  describe '#init' do
    it 'is an instance of Person' do
      expect(subject).to be_an_instance_of Person
    end

    it 'has a name' do
      expect(subject.name).to eql('Minerva')
    end

    it 'belongs to no banks' do
      expect(subject.banks).to eql({})
    end

    context 'when cash is positive' do
      it 'has a cash amount' do
        expect(subject.cash).to eql(1000)
      end

      context 'when cash is negative' do
        let(:cash) { -1000 }

        it 'defaults to zero' do
          expect(subject.cash).to eql(0)
        end
      end
    end
  end

  describe '#creation_msg' do
    it 'displays a creation message' do
      expect(subject.creation_msg).to eql('Minerva has been created with 1000 galleons in cash.')
    end
  end

  describe '#add_banks' do
    it 'adds an opened bank account' do
      chase = Bank.new('Chase')
      subject.add_bank(chase)
      expect(subject.banks).to eql({ 'Chase' => { balance: 0 } })
    end
  end
end
