class DocParserService
  attr_reader :text, :file_uuid, :ngrams_store, :language, :standart

  def initialize(file_path:, standart: false, language: nil)
    doc = Nokogiri::HTML(File.open(file_path))
    @text = doc.search('p').text.gsub("\n", '').gsub('.', ' ')
    @file_uuid = Digest::UUID.uuid_v3(Digest::UUID::DNS_NAMESPACE, text)
    @standart = standart
    @language = language
    @ngrams_store = {}
  end

  def call
    raise 'FileParsed' if HtmlFile.find_by(uuid: file_uuid)

    ActiveRecord::Base.transaction do
      file = HtmlFile.create!(standart: standart, uuid: file_uuid, language: language)
      ng = NGram.new({ size: 5, word_separator: ' ' })

      ngrams = ng.parse(text)
      ngrams.each do |ngrams_array|
        ngrams_array.each do |ngram|
          ngrams_store[ngram] ||= 0
          ngrams_store[ngram] += 1
        end
      end

      ngrams_store.keys.each do |key|
        Ngram.create!(html_file: file, frequency: ngrams_store[key], gram: key)
      end
    end
  end
end
