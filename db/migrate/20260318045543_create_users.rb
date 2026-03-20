class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :email
      t.string :name
      t.string :slack_id

      t.timestamps
    end
    add_index :users, :uid, unique: true
  end
end
