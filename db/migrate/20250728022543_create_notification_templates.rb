class CreateNotificationTemplates < ActiveRecord::Migration[8.0]
  def change
    create_table :notification_templates do |t|
      t.string :key, null: false, index: { unique: true }
      t.text :default_title
      t.text :default_body
      t.timestamps
    end
  end
end
