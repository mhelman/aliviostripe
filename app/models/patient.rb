class Patient < ActiveRecord::Base
  attr_accessible :firstName, :lastName, :email, :addresssStreet, :addresssCity, :addresssState, :addresssCountry, :addresssZipcode, :insuranceCompany
  belongs_to :user
  validates :user_id, presence: true
  validates :firstName, presence: true
  validates :email, presence: true
  default_scope -> { order('created_at DESC') }
end

