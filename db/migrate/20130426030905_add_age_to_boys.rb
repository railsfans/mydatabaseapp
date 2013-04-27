class AddAgeToBoys < ActiveRecord::Migration
  def change
    add_column :boys, :age, :integer
  end
end
