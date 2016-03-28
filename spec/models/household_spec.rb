require 'rails_helper'

RSpec.describe Household, type: :model do
  before(:each) do
    @enermis = User.create!(email: "Enermis@fulgens.com", password: "somePass")
    @fulgens = User.create!(email: "Fulgens@fulgens.com", password: "somePass")
    @ailurus = User.create!(email: "Ailurus@fulgens.com", password: "somePass")
    @household = Household.create!(creator: @enermis)
  end

  it "should have a creator" do
    @household.creator = @enermis
    expect(@household.creator).to eq(@enermis)
  end

  it "should require a creator" do
    expect{
      Household.create!(name: "sint-truiden")
    }.to raise_error ActiveRecord::RecordInvalid
  end

  it "should have many shopping lists" do
    shopping_list1 = ShoppingList.create!(creator: @enermis, household: @household)
    shopping_list2 = ShoppingList.create!(creator: @enermis, household: @household)
    expect(@household.reload.shopping_lists).to include(shopping_list1, shopping_list2)
  end

  it "should have many members" do
    @household.members << @fulgens
    @household.members << @ailurus
    expect(@household.members).to include(@fulgens, @ailurus)
  end


  it "should have many invites" do
    fulgens_invite = Invite.create(inviter: @enermis, invitee: @fulgens, household: @household)
    ailurus_invite = Invite.create(inviter: @enermis, invitee: @ailurus, household: @household)
    expect(@household.invites).to include(fulgens_invite, ailurus_invite)
  end

  it "should have a unique name per creator" do
    Household.create(name: "sint-truiden", creator: @enermis)
    expect {
      Household.create!(name: "sint-truiden", creator: @enermis)
    }.to raise_error ActiveRecord::RecordInvalid
  end

  describe 'a user' do
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
end
