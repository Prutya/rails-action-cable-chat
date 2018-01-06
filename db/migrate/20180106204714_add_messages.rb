class AddMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages, force: :cascade do |t|
      t.string :body
      t.references :user, index: true

      t.timestamps
    end
  end
end
