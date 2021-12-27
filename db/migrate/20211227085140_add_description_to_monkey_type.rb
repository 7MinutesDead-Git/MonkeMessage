class AddDescriptionToMonkeyType < ActiveRecord::Migration[7.0]
  def change
    add_column :monkey_types, :description, :text
  end
end
