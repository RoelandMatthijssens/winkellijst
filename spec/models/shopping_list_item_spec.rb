require 'rails_helper'

RSpec.describe ShoppingListItem, type: :model do
  before(:each) do
    @enermis = User.create!(email: 'Enermis@fulgens.com', password: 'somePass')
    @fulgens = User.create!(email: 'Fulgens@fulgens.com', password: 'somePass')
    @banana = Item.create(name: 'banana')
    @milk = Item.create!(name: 'milk')
    @shopping_list = ShoppingList.create!(creator: @enermis)
    @household = Household.create!(name: 'sint-truiden', creator: @enermis)
  end
  it 'should have an item' do
    shopping_list_item = ShoppingListItem.create!(minimum_params)
    expect(shopping_list_item.reload.item).to eq(@banana)
  end

  it 'should require an item' do
    expect{
      ShoppingListItem.create!(minimum_params.merge(item: nil))
    }.to raise_error ActiveRecord::RecordInvalid
  end

  it 'should have a shopping list' do
    shopping_list_item = ShoppingListItem.create!(minimum_params)
    expect(shopping_list_item.reload.shopping_list).to eq(@shopping_list)
  end

  it 'should require a shopping list' do
    expect{
      ShoppingListItem.create!(minimum_params.merge(shopping_list: nil))
    }.to raise_error ActiveRecord::RecordInvalid
  end

  it 'should have an amount' do
    shopping_list_item = ShoppingListItem.create!(minimum_params)
    expect(shopping_list_item.reload.amount).to eq(1)
  end

  it 'should keep track of who added the item' do
    shopping_list_item = ShoppingListItem.create!(minimum_params)
    expect(shopping_list_item.reload.added_by).to eq(@enermis)
  end

  it 'should be destroyed if it has 0 amount' do
    shopping_list_item = ShoppingListItem.create!(minimum_params)
    expect{
      shopping_list_item.amount = 0
      shopping_list_item.save!
    }.to change(ShoppingListItem, :count).by(-1)
  end

  it 'should be destroyed if it has less than 0 amount' do
    shopping_list_item = ShoppingListItem.create!(minimum_params)
    expect{
      shopping_list_item.amount = -12
      shopping_list_item.save!
    }.to change(ShoppingListItem, :count).by(-1)
  end

  describe 'a user' do
    describe 'adding items to a list' do
      describe 'permissions' do
        it 'should be able to add items to a shopping list he is the creator of' do
          shopping_list = ShoppingList.create!(creator: @enermis)
          @enermis.add_item_to_list(@banana, shopping_list)
          expect(list_contains_item(shopping_list, @banana)).to be_truthy
        end
        it 'should not be able to add items to other peoples lists' do
          shopping_list = ShoppingList.create!(creator: @fulgens)
          expect{
            @enermis.add_item_to_list(@banana, shopping_list)
          }.to raise_error CustomErrors::PermissionError
          expect(list_contains_item(shopping_list, @banana)).to be_falsey
        end
        it 'should be able to add items to the lists of his households' do
          @household.members << @fulgens
          shopping_list = ShoppingList.create!(creator: @fulgens, household:@household)
          expect{
            @enermis.add_item_to_list(@banana, shopping_list)
          }.not_to raise_error
          expect(list_contains_item(shopping_list, @banana)).to be_truthy
        end
        it 'should not be allowed to add items to lists of other households' do
          shopping_list = ShoppingList.create!(creator: @enermis, household:@household)
          expect{
            @fulgens.add_item_to_list(@banana, shopping_list)
          }.to raise_error CustomErrors::PermissionError
          expect(list_contains_item(shopping_list, @banana)).to be_falsey
        end
      end
      it 'should keep track of which user added the item to the list' do
        @enermis.add_item_to_list(@banana, @shopping_list)
        expect(@shopping_list.reload.shopping_list_items.first.added_by).to eq(@enermis)
      end
      it 'should add an amount of 1 to the list by default' do
        @enermis.add_item_to_list(@banana, @shopping_list)
        expect(@shopping_list.reload.shopping_list_items.first.amount).to eq(1)
      end
      it 'should add the specified amount to the list' do
        @enermis.add_item_to_list(@banana, @shopping_list, amount=3)
        expect(@shopping_list.reload.shopping_list_items.first.amount).to eq(3)
      end
      it 'should not create new shopping list items when adding the same item twice' do
        @enermis.add_item_to_list(@banana, @shopping_list)
        @enermis.add_item_to_list(@banana, @shopping_list)
        expect(@shopping_list.reload.shopping_list_items.size).to eq(1)
      end
      it 'should add the amount to an existing shopping list item' do
        @enermis.add_item_to_list(@banana, @shopping_list)
        @enermis.add_item_to_list(@banana, @shopping_list)
        expect(@shopping_list.reload.shopping_list_items.first.amount).to eq(2)
      end
    end
    describe 'removing items from a list' do
      before(:each) do
        @shopping_list_item = ShoppingListItem.create!(item: @banana, amount:5, shopping_list: @shopping_list)
      end

      it 'should subtract the amount' do
        @enermis.remove_item_from_list(@banana, @shopping_list, amount:3)
        expect(@shopping_list_item.reload.amount).to eq(2)
      end
      it 'should subtract the amount by 1 if no amount is specified' do
        @enermis.remove_item_from_list(@banana, @shopping_list)
        expect(@shopping_list_item.reload.amount).to eq(4)
      end
      it 'should remove the shopping list item when the amount is 0' do
        @enermis.remove_item_from_list(@banana, @shopping_list, amount:5)
        expect(list_contains_item(@shopping_list, @banana)).to be_falsey
      end
      it 'should remove the shopping list item when the amount is lower then 0' do
        @enermis.remove_item_from_list(@banana, @shopping_list, amount:12)
        expect(list_contains_item(@shopping_list, @banana)).to be_falsey
      end

      describe 'permissions' do
        it 'should be able to remove items from a shopping list he is the creator of' do
          @enermis.remove_item_from_list(@banana, @shopping_list)
          expect(@shopping_list_item.reload.amount).to eq(4)
        end
        it 'should not be able to remove items from other peoples lists' do
          expect{
            @fulgens.remove_item_from_list(@banana, @shopping_list)
          }.to raise_error CustomErrors::PermissionError
          expect(@shopping_list_item.reload.amount).to eq(5)
        end
        it 'should be able to remove items from the lists of his households' do
          @household.members<<@fulgens
          @shopping_list.household = @household
          @fulgens.remove_item_from_list(@banana, @shopping_list)
          expect(@shopping_list_item.reload.amount).to eq(4)
        end
        it 'should not be allowed to remove items from lists of other households' do
          @shopping_list.household = @household
          expect{
            @fulgens.remove_item_from_list(@banana, @shopping_list)
          }.to raise_error CustomErrors::PermissionError
          expect(@shopping_list_item.reload.amount).to eq(5)
        end
      end
    end
  end

  def minimum_params
    return {
        item: @banana,
        shopping_list: @shopping_list,
        amount: 1,
        added_by: @enermis
    }
  end

  def list_contains_item(list, item)
    !list.reload.shopping_list_items.find{ |shopping_list_item|
      shopping_list_item.id == item.id
    }.nil?
  end
end
