require 'list'

describe 'list' do
    let(:list1) { List.new('label')}

    let(:list2) do
        list = List.new('list')
        list.add_item('item1', '2021-12-31', 'description1')
        list.add_item('item2', '2021-3-1', 'description2')
        list.add_item('item3', '2019-10-31', 'description3')
        list
    end

    it "class should be defined" do
        expect(Object.const_defined?("List")).to eq(true)
    end

    it "@label, @items should have correct values" do
        expect(list1.instance_variable_get(:@label)).to eq('label')
        expect(list1.instance_variable_get(:@items)).to eq([])
        list1.label = 'label - updated'
        expect(list1.instance_variable_get(:@label)).to eq('label - updated')
    end

    context 'add_item' do
        it 'can add a new item to list' do
            list1.add_item('title', '2020-12-31', 'description')
            expect(list1.instance_variable_get(:@items)[0].title).to eq('title')
            expect(list1.instance_variable_get(:@items)[0].description).to eq('description')
            expect(list1.instance_variable_get(:@items)[0].deadline).to eq('2020-12-31')
        end

        it 'does not add a new item to list if date is invalid' do
            expect{list1.add_item('title', '2020-02-30', 'description')}.to raise_error
            expect(list1.instance_variable_get(:@items)).to eq([])
        end
    end

    context 'size' do
        it 'should accurately return the size of the list' do
            expect(list1.size).to eq(0)
            list1.add_item('title', '2020-12-31', 'description')
            expect(list1.size).to eq(1)
            list1.add_item('title', '2020-12-31', 'description')
            expect(list1.size).to eq(2)
            list1.add_item('title', '2020-12-31', 'description')
            expect(list1.size).to eq(3)
        end
    end

    context 'valid_index?' do
        it 'true if the index exists' do
            expect(list2.valid_index?(0)).to eq(true)
            expect(list2.valid_index?(1)).to eq(true)
            expect(list2.valid_index?(2)).to eq(true)
        end

        it 'false if the index does not exist' do
            expect(list2.valid_index?(3)).to eq(false)
            expect(list2.valid_index?(-1)).to eq(false)
        end
    end

    context 'swap & []' do
        it 'swaps if indexes are valid' do
            expect(list2.swap(0, 1)).to eq(true)
            expect(list2[0].title).to eq('item2')
            expect(list2[1].title).to eq('item1')
            expect(list2.swap(1, 2)).to eq(true)
            expect(list2[1].title).to eq('item3')
            expect(list2[2].title).to eq('item1')
            expect(list2.swap(0, 2)).to eq(true)
            expect(list2[0].title).to eq('item1')
            expect(list2[2].title).to eq('item2')
        end

        it 'does not swap if indexes are invalid' do
            expect(list2.swap(-1, 0)).to eq(false)
            expect(list2.swap(0, -1)).to eq(false)
            expect(list2.swap(0, 3)).to eq(false)
            expect(list2.swap(3, 0)).to eq(false)
            expect(list2.swap(3, 3)).to eq(false)
            expect(list2[0].title).to eq('item1')
            expect(list2[1].title).to eq('item2')
        end
    end

    context 'priority' do
        it 'returns the first item in @items' do
            expect(list2.priority.title).to eq('item1')
        end

        it 'returns nil if there are no items in @items' do
            expect(list1.priority).to eq(nil)
        end
    end

    context 'print functions' do
        it 'prints the current list' do
            list2.print
            list2.print_full_item(1)
            list2.print_priority
        end

        it '#print_full_item and #print_priority will return false if the index is invalid' do 
            expect(list1.print_full_item(1)).to eq(false)
            expect(list1.print_priority).to eq(false)
        end
    end

    context 'up' do
        it 'moves items up the list' do
            expect(list2.up(2, 2)).to eq(true)
            expect(list2[0].title).to eq('item3')
            expect(list2[1].title).to eq('item1')
            expect(list2[2].title).to eq('item2')
        end

        it 'moves items up 1 by default' do
            expect(list2.up(2)).to eq(true)
            expect(list2[0].title).to eq('item1')
            expect(list2[1].title).to eq('item3')
            expect(list2[2].title).to eq('item2')
        end

        it 'will not move items past first index' do
            expect(list2.up(2, 4)).to eq(true)
            expect(list2[0].title).to eq('item3')
            expect(list2[1].title).to eq('item1')
            expect(list2[2].title).to eq('item2')

            expect(list2.up(0)).to eq(true)
            expect(list2[0].title).to eq('item3')
            expect(list2[1].title).to eq('item1')
            expect(list2[2].title).to eq('item2')
        end
    end

    context 'down' do
        it 'moves items down the list' do
            expect(list2.down(0, 2)).to eq(true)
            expect(list2[0].title).to eq('item2')
            expect(list2[1].title).to eq('item3')
            expect(list2[2].title).to eq('item1')
        end

        it 'moves items up 1 by default' do
            expect(list2.down(0)).to eq(true)
            expect(list2[0].title).to eq('item2')
            expect(list2[1].title).to eq('item1')
            expect(list2[2].title).to eq('item3')
        end

        it 'will not move items past last index' do
            expect(list2.down(0, 4)).to eq(true)
            expect(list2[0].title).to eq('item2')
            expect(list2[1].title).to eq('item3')
            expect(list2[2].title).to eq('item1')

            expect(list2.down(2)).to eq(true)
            expect(list2[0].title).to eq('item2')
            expect(list2[1].title).to eq('item3')
            expect(list2[2].title).to eq('item1')
        end
    end

    context 'sort_by_date!' do
        it 'sorts the list correctly' do
            list2.sort_by_date!
            expect(list2[0].title).to eq('item3')
            expect(list2[1].title).to eq('item2')
            expect(list2[2].title).to eq('item1')
        end
    end

    context 'toggle_item' do
        it 'toggles item at the specified index and does not toggle other items' do
            list2.toggle_item(1)
            expect(list2[0].done).to eq(false)
            expect(list2[1].done).to eq(true)
            expect(list2[2].done).to eq(false)

            list2.toggle_item(1)
            expect(list2[0].done).to eq(false)
            expect(list2[1].done).to eq(false)
            expect(list2[2].done).to eq(false)
        end
    end

    context 'remove_item' do
        it 'removes the item at the specified index and does not remove other items' do 
            list2.remove_item(1)
            expect(list2.size).to eq(2)
            expect(list2[0].title).to eq('item1')
            expect(list2[1].title).to eq('item3')
        end

        it 'false if no item was removed' do
            expect(list2.remove_item(3)).to eq(false)
            expect(list2.size).to eq(3)
            expect(list2[0].title).to eq('item1')
            expect(list2[1].title).to eq('item2')
            expect(list2[2].title).to eq('item3')
        end
    end

    context 'purge' do 
        it 'removes all items from the list that are done' do
            list2.toggle_item(0)
            list2.toggle_item(2)
            list2.purge
            expect(list2.size).to eq(1)
            expect(list2[0].title).to eq('item2')
            expect(list2[0].done).to eq(false)
        end
    end

end