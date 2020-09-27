class AddNameToHtmlFiles < ActiveRecord::Migration[6.0]
  def change
    add_column :html_files, :name, :string
  end
end
