class BonAppetitWorker
  include Sidekiq::Worker

  def perform
    Menu::CAFE_UIDS.each do |cafe_uid, cafe_name|
      menu = Menu.find_or_initialize_by(cafe_uid: cafe_uid)
      dayparts = BonAppetitService.fetch_dayparts(cafe_uid: cafe_uid)
      menu.update!(dayparts: dayparts)
    end
  end
end
