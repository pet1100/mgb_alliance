class Confirmation < ApplicationRecord
  belongs_to :confirmed_for, :class_name => 'User'
  belongs_to :confirmed_by, :class_name => 'User'

  validates_uniqueness_of :confirmed_for, scope: :confirmed_by
  validates_uniqueness_of :code, scope: :confirmed_by
  validates :code, length: {is: 128}

  after_create do
    confirmed_for.decrement!(:rating)
    confirmed_by.increment!(:rating)
  end
end
