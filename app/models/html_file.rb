class HtmlFile < ActiveRecord::Base
  has_many :ngrams, -> { order(frequency: :desc) }, dependent: :destroy
  has_many :distances_from, class_name: 'Distance', foreign_key: :first_file_id, dependent: :destroy
  has_many :distances_to, class_name: 'Distance', foreign_key: :second_file_id, dependent: :destroy

  scope :saved, -> { where(standart: false) }
  scope :standart, -> { where(standart: true) }
end
