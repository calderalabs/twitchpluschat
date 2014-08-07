class CreateMessageBatches < ActiveRecord::Migration
  def change
    create_table :message_batches do |t|
      t.string :channel_id
      t.datetime :started_at
      t.datetime :ended_at
      t.json :messages, default: []

      t.timestamps
    end
  end
end
