class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :emoticon_set_ids, array: true, default: []

      t.timestamps
    end
  end
end
