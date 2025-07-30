class CreateNotificationRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :notification_requests do |t|
      t.string :notification_template_key, null: false, index: true
      t.string :recipient, null: false
      t.string :channel, null: false
      t.string :status, null: false, index: true
      t.jsonb :provider_response
      t.datetime :sent_at
      t.timestamps
    end

    add_foreign_key :notification_requests, :notification_templates, column: :notification_template_key, primary_key: :key
  end
end
