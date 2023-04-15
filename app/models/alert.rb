class Alert < ApplicationRecord
    belongs_to :user
    validates_uniqueness_of :price, :scope => :user_id
end
