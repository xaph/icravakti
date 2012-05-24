class AddArchivedToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :archived, :boolean, :default => false
  end
end
