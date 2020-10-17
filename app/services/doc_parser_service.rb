class DocParserService
  attr_reader :text, :file_uuid, :ngrams_store, :language, :standart, :file_name

  def initialize(file_path:, standart: false, language: nil, file_name: nil)
    doc = Nokogiri::HTML(File.open(file_path))
    @text = doc.search('p').text.gsub("\n", '').gsub('.', ' ')
    @file_uuid = Digest::UUID.uuid_v3(Digest::UUID::DNS_NAMESPACE, text)
    @standart = standart
    @language = language
    @file_name = file_name
    @ngrams_store = {}
  end

  def call
    html_file = HtmlFile.find_by(uuid: file_uuid)
    return html_file if html_file

    ActiveRecord::Base.transaction do
      file = HtmlFile.create!(standart: standart, uuid: file_uuid, language: language, name: file_name)
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

      file.update!(alphabet: build_alphabet(file))

      file
    end
  end

  private

  def build_alphabet(file)
    file.ngrams.pluck(:gram).join.gsub('_', '').downcase.split('').uniq.join
  end
end
