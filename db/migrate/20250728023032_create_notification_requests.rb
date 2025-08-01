class CreateNotificationRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :notification_requests do |t|
      t.references :notification_template, null: false, foreign_key: true
      t.string :recipient, null: false
      t.string :channel, null: false
      t.string :status, null: false, index: true
      t.jsonb :provider_response
      t.datetime :sent_at
      t.timestamps
    end
  end
end
