class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :loan_id
      t.integer :payment_value
      t.boolean :paid
      t.date :payment_date

      t.timestamps
    end
  end
end
