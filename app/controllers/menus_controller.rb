class MenusController < ApplicationController
  def index
    @menus = Menu::CAFE_UIDS.map do |cafe_name, cafe_uid|
      [cafe_name, Menu.order(:created_at).where(cafe_uid: cafe_uid).last]
    end.to_h
  end
end
