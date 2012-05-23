class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.integer :user_id
      t.integer :borrower_id
      t.integer :value
      t.text :description
      t.integer :paid_value, :default => 0

      t.timestamps
    end
  end
end
