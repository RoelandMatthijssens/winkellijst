require 'rails_helper'

RSpec.describe Invite, type: :model do
  before(:each) do
    @enermis = User.create!(email: "enermis@fulgens.com", password: "somepass")
    @fulgens = User.create!(email: "fulgens@fulgens.com", password: "somepass")
    @sint_truiden = Household.create!(name: "sint-truiden", creator: @enermis)
  end
  it "should have an inviter" do
    invite = Invite.create!(minimum_params)
    expect(invite.inviter).to eq(@enermis)
  end
  it "should require an inviter" do
    expect{
      Invite.create!(minimum_params.merge inviter: nil)
    }.to raise_error ActiveRecord::RecordInvalid
  end
  it "should have an invitee" do
    invite = Invite.create!(minimum_params)
    expect(invite.invitee).to eq(@fulgens)
  end
  it "should require an invitee" do
    expect{
      Invite.create!(minimum_params.merge invitee: nil)
    }.to raise_error ActiveRecord::RecordInvalid
  end
  it "should have a household" do
    invite = Invite.create!(minimum_params)
    expect(invite.household).to eq(@sint_truiden)
  end
  it "should require a household" do
    expect{
      Invite.create!(minimum_params.merge household: nil)
    }.to raise_error ActiveRecord::RecordInvalid
  end

  describe 'a user' do
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

  def minimum_params
    return {
        inviter: @enermis,
        invitee: @fulgens,
        household: @sint_truiden
    }
  end
end
