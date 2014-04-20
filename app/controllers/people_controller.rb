class PeopleController < ApplicationController
  
  def search
    request=params[:firstname]+'%'
    @res=Person.select(:id,:firstname,:lastname).where("firstname LIKE ?",request)
    respond_to do |format|
      format.html {render "404"}
      format.json {render json: @res}
    end
  end
end