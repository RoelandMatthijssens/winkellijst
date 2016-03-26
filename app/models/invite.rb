class Invite < ActiveRecord::Base
  belongs_to :inviter, class_name: 'User'
  belongs_to :invitee, class_name: 'User'
  belongs_to :household

  validates :inviter, presence: true
  validates :invitee, presence: true
  validates :household, presence: true

end
