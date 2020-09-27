class CreateFilesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :html_files do |t|
      t.string :language
      t.string :uuid, uniq: true, index: true
      t.boolean :standart

      t.timestamps
    end
  end
end
