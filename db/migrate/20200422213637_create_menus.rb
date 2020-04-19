class CreateMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :menus do |t|
      t.string :cafe_uid, null: false
      t.jsonb :dayparts, null: false
      t.timestamps
    end

    add_index :menus, :cafe_uid, unique: true
  end
end
