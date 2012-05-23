class CreateBorrowers < ActiveRecord::Migration
  def change
    create_table :borrowers do |t|
      t.string :name
      t.string :facebook_name
      t.string :twitter_name
      t.string :info

      t.timestamps
    end
  end
end
