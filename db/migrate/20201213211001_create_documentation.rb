class CreateDocumentation < ActiveRecord::Migration[6.2]
  def change
    create_table :documentation do |t|
      t.text(:text)
      t.string(:slack_user_id)
      t.string(:slack_channel_id)
      t.string(:slack_timestamp)

      t.timestamps
    end
  end
end
