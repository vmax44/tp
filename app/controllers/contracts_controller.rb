class ContractsController < ApplicationController
   before_filter :authenticate_user!
  
  def index
    @session=session[:filter] ||= {}
    @contracts=current_user.contracts
            .joins(:insurant,:insured,:user)
            .filter(@session)
            .paginate(page: params[:page], per_page: 10)
  end
  
  def print
    @contract=current_user.contracts.find(params[:id])
    render 'edit'
  end

  def new
    @contract=current_user.contracts.new
    @contract.number=(Contract.last.number.to_i+1).to_s
    #@contract.build_insurant
    #@contract.insurant.build_organization
    #@contract.build_insured
    @organizations=Organization.all
    
  end
  
  def create
    @contract=current_user.contracts.new(contract_params)

    if @contract.save
      flash[:success]= t(:contract_added)
      #redirect_to(contracts_path)
      contractnew=current_user.contracts.new
      contractnew.number=(@contract.number.to_i+1).to_s
      contractnew.date=@contract.date
      contractnew.datestart=@contract.datestart
      contractnew.datefinish=@contract.datefinish
      contractnew.cost=@contract.cost
      contractnew.insurant_id=@contract.insurant_id
      @contract=contractnew
    end
    @organizations=Organization.all
    render 'new'
  end
  
  def edit
    @contract=current_user.contracts.find(params[:id]).localized
  end
  
  def update
    @contract=current_user.contracts.find(params[:id])
    if @contract.update_attributes(contract_params)
      flash[:success]= t(:contract_updated)
      redirect_to(contracts_path)
    else
      @organizations=Organization.all
      render 'edit'
    end
  end
  
  def destroy
    if current_user.contracts.find(params[:id]).delete
      flash[:success]='Policy deleted successfully!'
    else
      flash[:error]='Error while deleting policy'
    end
    redirect_to(contracts_path)
  end
  
  def save_filter
    session[:filter] ||= {}
    filter_params.each { |key,val| session[:filter][key]=val }
    flash[:success]='Filter updated'
    redirect_to(contracts_path)
  end
  
  def clear_filter
    session[:filter] ||= {}
    filter_arr.each { |key,val| session[:filter][key]=""}
    flash[:success]='Filter cleared'
    redirect_to(contracts_path)
  end
  
  private
  
    def contract_params
      params.require(:contract).permit(:number, :insurant_id, :insured_id, :cost, 
                                     :date, :datestart, :datefinish,
                                      insurant_attributes:[:id, :firstname, :lastname, :organization_id],
                                      insured_attributes:[:id, :firstname, :lastname])
    end
  
    def filter_params
      params.require(:filter).permit(filter_arr)
    end
    
    def filter_arr
      ["fnumber", "finsurant_name", "finsured_name", "fcost", 
       "fdate_f", "fdate_l", "fdatestart_f", "fdatestart_l",
       "fdatefinish_f", "fdatefinish_l", "fikp"]
    end
    
end
