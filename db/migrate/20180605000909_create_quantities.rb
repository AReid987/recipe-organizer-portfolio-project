class CreateQuantities < ActiveRecord::Migration[5.2]
  def change
    create_table :quantities do |t|
      t.integer :ingredient_id
      t.string :amount
      t.timestamps
    end
  end
end
