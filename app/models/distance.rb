class Distance < ActiveRecord::Base
  belongs_to :first_file, class_name: 'HtmlFile'
  belongs_to :second_file, class_name: 'HtmlFile'
end
