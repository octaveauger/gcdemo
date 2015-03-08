class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :mandate, index: true
      t.string :gc_subscription_id

      t.timestamps
    end
  end
end
