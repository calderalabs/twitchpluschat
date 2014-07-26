class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :text
      t.string :channel_id
      t.string :user_id

      t.timestamps
    end
  end
end
