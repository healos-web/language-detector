require 'nokogiri'
require 'active_support/core_ext/digest/uuid'

namespace :language_detector do
  desc 'index standart files from texts folder'
  task :index_standart_files do
    Dir['./app/views/texts/*.html'].each do |file_path|
      lang = file_path.split('/').last.split('.').first
      DocParserService.new(file_path: file_path, standart: true, language: lang).call
    end
  end
end
