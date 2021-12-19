class AddMoreNamesToMonkeyTypes < ActiveRecord::Migration[7.0]
  def change
    add_column :monkey_types, :scientific_name, :string
    add_column :monkey_types, :colloquial_name, :string
  end
end
