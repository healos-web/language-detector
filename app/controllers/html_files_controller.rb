class LanguageDetector < ApplicationControllerBase
  get '/' do
    slim :index
  end

  get '/files/:id' do
    @file = HtmlFile.find(params[:id])

    slim :"files/show"
  end

  post '/detect-language' do
    tempfile = params[:file][:tempfile]

    ActiveRecord::Base.transaction do
      html_file = DocParserService.new(file_path: tempfile.path, file_name: params[:file][:filename]).call

      case params[:method]
      when 'alphabet'
        LanguageDetectorAlphabetService.new(html_file: html_file).call
      when 'ngram'
        LanguageDetectorNgramService.new(html_file: html_file).call
      when 'lib'
        LanguageDetectorLibService.new(html_file: html_file, file_path: tempfile.path).call
      end

      redirect "/files/#{html_file.id}"
    end
  end
end
