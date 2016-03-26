require 'CustomErrors'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :households
  has_many :invites, foreign_key: :invitee_id
  has_many :shopping_lists, foreign_key: :creator_id

  def create_household(household_name)
    begin
      return Household.create!(name: household_name, creator: self)
    rescue ActiveRecord::RecordInvalid => e
      raise CustomErrors::UniqueRecordError
    end
  end

  def invite_user_to_household(user, household)
    if household.creator == self
      Invite.create!(inviter: self, invitee:user, household:household)
    else
      raise CustomErrors::PermissionError
    end
  end

  def accept_invite(invite)
    if invite.invitee == self
      invite.household.members << self
    else
      raise CustomErrors::PermissionError
    end
  end

  def create_shopping_list(household = nil)
    if household.nil? || household.members.member?(self)
      ShoppingList.create!(creator: self, household: household)
    else
      raise CustomErrors::PermissionError
    end
  end
end
