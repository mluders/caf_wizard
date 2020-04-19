class MenusController < ApplicationController
  def index
    @menus = Menu.most_recent
  end
end
