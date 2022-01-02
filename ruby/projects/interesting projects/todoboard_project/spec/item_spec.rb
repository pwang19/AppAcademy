require 'item'

describe 'item' do
    let(:item1) { Item.new('title', '2020-12-31', 'description')}

    it "class should be defined" do
        expect(Object.const_defined?("Item")).to eq(true)
    end

    it "all instance variables should pull in correct values" do
        expect(item1.instance_variable_get(:@title)).to eq('title')
        expect(item1.instance_variable_get(:@description)).to eq('description')
        expect(item1.instance_variable_get(:@deadline)).to eq('2020-12-31')
        expect(item1.instance_variable_get(:@done)).to eq(false)

        item1.title = 'title - updated'
        item1.description = 'description - updated'
        item1.deadline = '2021-01-01'

        expect(item1.instance_variable_get(:@title)).to eq('title - updated')
        expect(item1.instance_variable_get(:@description)).to eq('description - updated')
        expect(item1.instance_variable_get(:@deadline)).to eq('2021-01-01')
    end

    context 'valid_date?' do
        it 'recognizes dates in Y-M-D formats' do
            expect(Item.valid_date?('1-1-1')).to eq(true)
            expect(Item.valid_date?('2050-1-1')).to eq(true)
            expect(Item.valid_date?('2050-12-31')).to eq(true)
            expect(Item.valid_date?('4321-2-28')).to eq(true)
        end

        it 'recognizes leap years and non-leap years' do
            expect(Item.valid_date?('2000-2-29')).to eq(true)
            expect(Item.valid_date?('2001-2-29')).to eq(false)
            expect(Item.valid_date?('2002-2-29')).to eq(false)
            expect(Item.valid_date?('2003-2-29')).to eq(false)
            expect(Item.valid_date?('2004-2-29')).to eq(true)
        end

        it 'recognizes incorrect inputs' do
            expect(Item.valid_date?('2000-13-15')).to eq(false)
            expect(Item.valid_date?('2000-0-15')).to eq(false)
            expect(Item.valid_date?('2000-1-0')).to eq(false)
            expect(Item.valid_date?('2000')).to eq(false)
            expect(Item.valid_date?('2000-1')).to eq(false)
            expect(Item.valid_date?('2000/1/1')).to eq(false)
            expect(Item.valid_date?('2000 1 1')).to eq(false)
            expect(Item.valid_date?('1-1-2000')).to eq(false)
        end
    end

    context 'toggle' do
        it 'should toggle it from incomplete to complete and vice versa' do
            item1.toggle
            expect(item1.done).to eq(true)
            item1.toggle
            expect(item1.done).to eq(false)
        end
    end


end