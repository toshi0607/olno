class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :user_id
      t.datetime :logged_in_at
      t.datetime :logged_out_at

      t.timestamps null: false
    end
  end
end
