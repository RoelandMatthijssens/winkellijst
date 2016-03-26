require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @enermis = User.create!(email: 'enermis@fulgens.com', password: 'somepass')
  end
  describe 'households' do
    it 'should be a member of any household it creates' do
      sint_truiden = @enermis.create_household(name: 'sint-truiden')
      expect(sint_truiden.members).to include(@enermis)
    end

    it 'should only be able to create a household with a specific name once' do
      @enermis.create_household(name: 'sint-truiden')
      expect{
        @enermis.create_household(name: 'sint-truiden')
      }.to raise_error CustomErrors::UniqueRecordError
    end
  end
  describe 'shopping lists' do
    it 'should have many shopping lists' do
      shopping_list1 = ShoppingList.create!(creator: @enermis)
      shopping_list2 = ShoppingList.create!(creator: @enermis)
      expect(@enermis.shopping_lists).to include(shopping_list1, shopping_list2)
    end
    it 'should be able to create a shopping list for himself' do
      shopping_list = @enermis.create_shopping_list
      expect(@enermis.shopping_lists).to include(shopping_list)
    end
    it 'should be able to create a shopping list for his household' do
      household = Household.create!(creator: @enermis, name: 'sint-truiden')
      shopping_list = @enermis.create_shopping_list(household)
      expect(@enermis.shopping_lists).to include(shopping_list)
      expect(household.shopping_lists).to include(shopping_list)
    end
    it 'should not be able to create shopping lists for a household he is not a member of' do
      household = Household.create!(creator: @enermis, name: 'sint-truiden')
      fulgens = User.create!(email: 'fulgens@fulgens.com', password: 'somepass')
      expect{
        fulgens.create_shopping_list(household)
      }.to raise_error CustomErrors::PermissionError
    end
    it 'should be able to add items to a shopping list' do
      shopping_list = ShoppingList.create!(creator: @enermis)
      banana = Item.create!(name: 'banana')
      @enermis.add_item_to_list(banana, shopping_list)
      expect(myArray.find { |item| item[:id] == 5 }).to_not be_nil

      expect(shopping_list.reload.shopping_list_items).to include()

    end
  end
  describe 'invites' do
    before(:each) do
      @fulgens = User.create!(email: 'fulgens@fulgens.com', password: 'somepass')
      @sint_truiden = @enermis.create_household(name: 'sint-truiden')
    end

    it 'should be able to invite users to the household' do
      invite = @enermis.invite_user_to_household(@fulgens, @sint_truiden)
      expect(invite).to have_attributes(inviter:@enermis, invitee:@fulgens, household:@sint_truiden)
      expect(@fulgens.invites).to include(invite)
      expect(@enermis.invites).to be_empty
    end

    it 'should be able to accept invites to a household' do
      invite = @enermis.invite_user_to_household(@fulgens, @sint_truiden)
      expect(@sint_truiden.members).not_to include(@fulgens)
      @fulgens.accept_invite(invite)
      expect(@sint_truiden.members).to include(@fulgens)
    end

    it 'should only be able to invite users to a household he created' do
      ailurus = User.create!(email: 'ailurus@fulgens.com', password: 'somepass')
      expect {
        @fulgens.invite_user_to_household(ailurus, @sint_truiden)
      }.to raise_error CustomErrors::PermissionError
    end

    it 'should only be able to accept invites directed to him' do
      invite = @enermis.invite_user_to_household(@fulgens, @sint_truiden)
      ailurus = User.create!(email: 'ailurus@fulgens.com', password: 'somepass')
      expect{
        ailurus.accept_invite(invite)
      }.to raise_error CustomErrors::PermissionError
      expect(@sint_truiden.members).to_not include(ailurus)
    end
  end
end
