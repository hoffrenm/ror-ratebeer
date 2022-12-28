class BeerClub < ApplicationRecord
  has_many :memberships
  has_many :members, -> { where("memberships.confirmed = ?", true) }, through: :memberships, source: :user
  has_many :applicants, -> { where("memberships.confirmed = ?", false) }, through: :memberships, source: :user
end
