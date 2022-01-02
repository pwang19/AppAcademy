require 'card.rb'

describe 'Card' do
    let(:card) {Card.new('value')}

    it 'initializes local variables correctly' do
        expect(card.instance_variable_get(:@value)).to eq 'value'
        expect(card.instance_variable_get(:@up)).to eq false
    end

    context '#reveal and #hide' do
    it 'reveals and hides the card' do
        card.reveal
        expect(card.up).to eq true
        card.reveal
        expect(card.up).to eq true
        card.hide
        expect(card.up).to eq false
        card.hide
        expect(card.up).to eq false
    end
end

    context '#to_s' do
    it 'returns the value' do
        expect(card.to_s).to eq 'value'
    end
end

    context '#==' do
    it 'true if the values of each card are the same' do
        expect(card == Card.new('value')).to eq true
    end

    it 'false if the values of each card are different' do
        expect(card == Card.new('Value')).to eq false
    end
end

end