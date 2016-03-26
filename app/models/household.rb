class Household < ActiveRecord::Base
  before_create :add_creator_to_members
  validates_uniqueness_of :name, :scope => :creator_id
  validates :creator, presence: true

  belongs_to :creator, class_name: 'User'
  has_many :invites
  has_many :shopping_lists
  has_and_belongs_to_many :members, join_table: 'households_users', class_name: 'User'

  private
  def add_creator_to_members
    self.members << self.creator
  end
end
