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
  
  def validate
    person = Person.new(person_params)
    validator(person)
    respond_to do |format|
      format.json { render json: @errors }
    end

  end
  
  def new
    @person=Person.new
    respond_to do |format|
      format.js {}
      format.html {render 'new', :layout => !request.xhr?}
    end
  end
  
  def create
    @person=Person.new(person_params)
    respond_to do |format|
      format.html {
        @person.save
        render 'new', :layout=>!request.xhr?
      }

    end
  end
  
  def edit
    @person=Person.find(params[:id])
    respond_to do |format|
      format.js {render 'edit'}
    end
  end
  
  def update
    @person=Person.find(params[:id])
    respond_to do |format|
      @person.update_attributes(person_params)
      format.html {
        render 'edit', :layout=>!request.xhr?
      }
    end
    
  end
  
  private
  def person_params
    params.require(:person).permit(:firstname,:lastname,:address,:passport,:organization_id)
  end
end