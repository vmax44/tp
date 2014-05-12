class FilterController < ApplicationController
  before_filter :authenticate_user!
  
  def new
  end
  
  def create
    #destroy
    #@filter=session["filter"] || {}
    params[:filter].each { |key,val| 
      #if !val.empty? then 
        session[key]=val 
      #end
    }
    render :index
  end

  def index
    @filter=session[:filter]
    if @filter.nil? then
      @filter={:number => ""}
    
    end
  end
  
  def destroy
    session[:filter]=nil
  end
  
  private
  
    def filter_params
      params.require(:filter).permit(:number, :insurant_name, :insured_name, :cost, 
                                     :date_f, :date_l, :datestart_f, :datestart_l,
                                     :datefinish_f, :datefinish_l)
    end
end