class Menu < ApplicationRecord
  CAFE_UIDS = {
    '17' => 'cafe_biola',
    '742' => 'meal_exchange'
  }

  validates :cafe_uid, presence: true, uniqueness: true

  def self.most_recent
    Menu.where(cafe_uid: [CAFE_UIDS.keys])
  end

  def cafe_name
    CAFE_UIDS[cafe_uid]
  end
end
