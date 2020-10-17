class LanguageDetectorLibService
  attr_reader :html_file, :file_path

  LANG_MAP = {
    'es' => 'spanish',
    'en' => 'english'
  }.freeze

  def initialize(html_file:, file_path:)
    @html_file = html_file
    @file_path = file_path
  end

  def call
    text = Nokogiri::HTML(File.open(file_path)).search('p').text

    result = DetectLanguage.detect(text)[0]
    html_file.update!(language: LANG_MAP[result['language']])
  end
end
