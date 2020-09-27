class HtmlFile < ActiveRecord::Base
  has_many :ngrams, -> { order(frequency: :desc) }, dependent: :destroy
end
