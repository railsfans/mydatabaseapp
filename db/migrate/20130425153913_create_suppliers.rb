class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :company
      t.string :address
      t.string :contactor
      t.string :phone
      t.string :fax
      t.string :email
      t.string :comment

      t.timestamps
    end
  end
end
