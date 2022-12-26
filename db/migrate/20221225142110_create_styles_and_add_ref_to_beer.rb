class CreateStylesAndAddRefToBeer < ActiveRecord::Migration[7.0]
  def change
    create_table :styles do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    
    rename_column :beers, :style, :old_style
    add_reference :beers, :style, index: true, foreign_key: true
  end
end
