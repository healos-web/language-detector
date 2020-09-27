class LanguageDetector < ApplicationControllerBase
  get '/' do
    slim :index
  end

  get '/files/:id' do
    @html_file = HtmlFile.find(params[:id])

    slim 'files/show'
  end

  post '/detect-language' do
    tempfile = params[:file][:tempfile]
    html_file = DetectLanguageService.new(file_path: tempfile.path, file_name: params[:file][:filename]).call

    redirect "/files/#{html_file.id}"
  end
end
