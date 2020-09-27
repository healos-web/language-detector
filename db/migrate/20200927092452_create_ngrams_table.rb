class CreateNgramsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :ngrams do |t|
      t.integer :frequency, index: true
      t.string :gram, index: true
      t.belongs_to :html_file, index: true, foreign_key: true
    end
  end
end
