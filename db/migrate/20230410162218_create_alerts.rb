class CreateAlerts < ActiveRecord::Migration[7.0]
  def change
    create_table :alerts do |t|
      t.string :status, :null => false, :default => 'created'
      t.decimal :price, :null => false, :default => 0.0
      t.integer :user_id

      t.timestamps
    end
  end
end
