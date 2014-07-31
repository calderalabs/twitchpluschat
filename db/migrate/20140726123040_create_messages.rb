class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :text
      t.string :channel_id
      t.references :user

      t.timestamps
    end
  end
end
