class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :favorite

  def favorite
    @favorites ||= Favorite.new(session[:favorites])
  end
end
