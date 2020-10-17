class AddAlphabetToHtmlFiles < ActiveRecord::Migration[6.0]
  def change
    add_column :html_files, :alphabet, :string
  end
end
