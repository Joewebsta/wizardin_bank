require './lib/bank'

describe Bank do
  subject { Bank.new('JP Morgan Chase') }

  describe '#init' do
    it 'has a name' do
      expect(subject.name).to eql('JP Morgan Chase')
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
end
