class LanguageDetectorAlphabetService
  attr_reader :html_file

  def initialize(html_file:)
    @html_file = html_file
  end

  def call
    min_diff = {}

    HtmlFile.standart.each do |file|
      diff = file.alphabet.split('') - html_file.alphabet.split('')

      if diff.length < min_diff[:value] || !min_diff[:value]
        min_diff[:file] = file
        min_diff[:value] = diff
      end
    end

    html_file.update!(language: min_diff[:file].language)
  end
end
