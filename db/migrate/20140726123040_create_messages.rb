class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :text
      t.string :channel_id
      t.string :user_name
      t.string :emoticon_set_ids, array: true, default: []
      t.string :color

      t.timestamps
    end
  end
end
