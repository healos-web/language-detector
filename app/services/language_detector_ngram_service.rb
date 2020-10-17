class LanguageDetectorNgramService
  attr_reader :html_file

  def initialize(html_file:)
    @html_file = html_file
  end

  def call
    positions = parse_positions(html_file.ngrams.order(frequency: :desc))

    HtmlFile.includes(:ngrams).where(standart: true).each do |file|
      Distance.create!(first_file: html_file, second_file: file, value: count_distance(positions, parse_positions(file.ngrams)))
    end
    result_lang = html_file.distances_from.order(:value).first.second_file.language

    html_file.update!(language: result_lang)
    html_file
  end

  private

  def parse_positions(grams)
    positions = {}

    grams.each_with_index do |ng, index|
      positions[ng.gram] = index
    end

    positions
  end

  def count_distance(positions, standart_positions)
    differences = []
    max_distances = 0
    positions.keys.each do |key|
      if standart_positions[key]
        differences << (positions[key] - standart_positions[key]).abs
      else
        max_distances += 1
      end
    end

    differences.sum + differences.max * max_distances
  end
end
