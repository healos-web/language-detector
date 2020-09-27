class CreateDistances < ActiveRecord::Migration[6.0]
  def change
    create_table :distances do |t|
      t.belongs_to :first_file
      t.belongs_to :second_file
      t.integer :value

      t.timestamps
    end
  end
end
