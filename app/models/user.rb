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

  def add_item_to_list(item, shopping_list, amount=1)
    if can_add_to_list?(shopping_list)
      ShoppingListItem.add_to_shopping_list_item(shopping_list, item, amount, self)
    else
      raise CustomErrors::PermissionError
    end
  end

  def remove_item_from_list(item, shopping_list, amount:1)
    if can_add_to_list?(shopping_list)
      shopping_list.shopping_list_items.map do |shopping_list_item|
        if shopping_list_item.item == item
          shopping_list_item.amount-=amount
          shopping_list_item.save!
        end
      end
    else
      raise CustomErrors::PermissionError
    end
  end

  def mark_item_as_bought(shopping_list_item)
    if can_add_to_list?(shopping_list_item.shopping_list)
      shopping_list_item.bought=true
      shopping_list_item.save!
    else
      raise CustomErrors::PermissionError
    end
  end

  private
  def can_add_to_list?(list)
    household = list.household
    list.creator == self || (!household.nil? && household.members.member?(self))
  end
end
