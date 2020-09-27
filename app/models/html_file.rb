class HtmlFile < ActiveRecord::Base
  has_many :ngrams, -> { order(frequency: :desc) }, dependent: :destroy
  has_many :distances_from, inverse_of: :first_file, class_name: 'Distance', foreign_key: :first_file_id
  has_many :distances_to, inverse_of: :second_file, class_name: 'Distance', foreign_key: :second_file_id
end
