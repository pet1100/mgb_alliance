class User < ApplicationRecord
  has_one :uuid

  before_create do
    last_used = Time.now
  end

end
