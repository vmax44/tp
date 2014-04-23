class PeopleController < ApplicationController
  before_filter :authenticate_user!
  
  def search
    fname=params[:firstname]+'%'
    lname=params[:lastname]+'%'
    @res=Person.select(:id,:firstname,:lastname).where("firstname LIKE ? and lastname LIKE ?",fname, lname)
    respond_to do |format|
      format.html {render "404"}
      format.json {render json: @res}
    end
  end
end