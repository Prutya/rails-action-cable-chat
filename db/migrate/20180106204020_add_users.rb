class AddUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, force: :cascade do |t|
      t.string :username
      t.string :password_digest

      t.timestamps
    end

    add_index :users, :username
  end
end
