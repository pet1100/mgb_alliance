class User < ApplicationRecord
  has_many :confirmed_for_me, :class_name => 'Confirmation', :foreign_key => 'confirmed_for_id'
  has_many :i_have_confirmed, :class_name => 'Confirmation', :foreign_key => 'confirmed_by_id'

  scope :active_within_a_week, -> { where("last_used > ?", 7.days.ago) }
  scope :not_confirmed_by_user, -> (user) { where.not(id: Confirmation.where(confirmed_by: user).select(:confirmed_for_id)) }
  scope :without_user,  -> (user) { where.not(id: user.id) }
  before_create do
    last_used = Time.now
  end

end
