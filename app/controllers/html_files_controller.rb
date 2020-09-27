class LanguageDetector < ApplicationControllerBase
  get '/' do
    slim :index
  end

  get '/files/:id' do
    @html_file = HtmlFile.find(params[:id])
  end

  post '/detect-language' do
    html_file = DetectLanguageService.new(params[:file].path).call

    redirect "/files/#{html_file.id}"
  end
end
