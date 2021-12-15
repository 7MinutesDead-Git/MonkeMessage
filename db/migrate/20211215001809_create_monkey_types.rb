class CreateMonkeyTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :monkey_types do |t|
      t.string :name
      t.integer :friendliness
      t.integer :age
      t.timestamps
    end
  end
end
