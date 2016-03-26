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

  def minimum_params
    return {
        inviter: @enermis,
        invitee: @fulgens,
        household: @sint_truiden
    }
  end
end
