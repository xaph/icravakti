class AddEmailToBorrowers < ActiveRecord::Migration
  def change
    add_column :borrowers, :email, :string
  end
end
