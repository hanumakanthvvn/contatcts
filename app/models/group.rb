class Group < ApplicationRecord
	belongs_to :user

	has_many :contacts
	scope :active_groups, -> { where(is_active: true) }
end
