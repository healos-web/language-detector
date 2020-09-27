class LanguageDetectorService
  attr_reader :html_file

  def initialize(file_path:)
    @html_file = DocParserService.new(file_path: file_path).call
  end

  def call
    positions = html_file.ngrams.order(frequency: :desc)
    distances = []

    HtmlFile.includes(:ngrams).where(standart: true).each do |file|
      distances << { lang: file.language, distance: count_distance(positions, parse_positions(file.ngrams)) }
    end

    result_lang = (distances.max { |a, b| a[:distance] <=> b[:distance] })

    { distances: distances, language: result_lang }
  end

  private

  def parse_positions(grams)
    positions = {}

    grams.each_with_index do |ng, index|
      positions[ng.gram] = index
    end
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
