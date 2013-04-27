class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.integer :itemNo
      t.string :partName
      t.string :partRef
      t.string :footprint
      t.string :manufacturer
      t.integer :quantity
      t.float :unitprice
      t.float :totalprice
      t.integer :supplier_id
      t.string :comment

      t.timestamps
    end
  end
end
