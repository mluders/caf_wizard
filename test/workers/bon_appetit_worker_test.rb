require 'test_helper'

class BonAppetitWorkerTest < ActiveSupport::TestCase
  setup :setup_test_data

  def test_fetch_dayparts
    existing_uid = Menu::CAFE_UIDS.keys.first
    existing_menu = Menu.create!(
      cafe_uid: existing_uid,
      dayparts: { existing_dayparts: existing_uid }
    )

    assert_difference 'Menu.count', Menu::CAFE_UIDS.size - 1 do
      BonAppetitWorker.new.perform
    end

    existing_menu.reload

    Menu.all.each do |menu|
      expected_dayparts = { "new_dayparts" => menu.cafe_uid }
      assert_equal expected_dayparts, menu.dayparts
    end
  end

  def setup_test_data
    Menu.destroy_all

    Menu::CAFE_UIDS.each do |cafe_uid, cafe_name|
      BonAppetitService.stubs(:fetch_dayparts).with(cafe_uid: cafe_uid).returns({ "new_dayparts" => cafe_uid})
    end
  end
end
