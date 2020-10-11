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
      html_file = LanguageDetectorService.new(file_path: tempfile.path, file_name: params[:file][:filename]).call

      redirect "/files/#{html_file.id}"
    end
  end
end
