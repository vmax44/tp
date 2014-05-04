class ContractsController < ApplicationController
   before_filter :authenticate_user!
  
  def index
    @contracts=current_user.contracts.includes(:strahovatel,:zastrahovanniy,:user).paginate(page: params[:page], 
                                               per_page: 10)
  end
  


  def new
    @contract=current_user.contracts.new
    @contract.number=(Contract.last.number.to_i+1).to_s
    #@contract.build_strahovatel
    #@contract.strahovatel.build_organization
    #@contract.build_zastrahovanniy
    #@organizations=Organization.all
    
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
      contractnew.strahovatel_id=@contract.strahovatel_id
      @contract=contractnew
    end
    #@organizations=Organization.all
    render 'new'
  end
  
  def edit
    @contract=current_user.contracts.find(params[:id])
    @organizations=Organization.all
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
  
  private
  
    def contract_params
      params.require(:contract).permit(:number, :strahovatel_id, :zastrahovanniy_id, :cost, 
                                     :date, :datestart, :datefinish,
                                      strahovatel_attributes:[:id, :firstname, :lastname, :organization_id],
                                      zastrahovanniy_attributes:[:id, :firstname, :lastname])
    end
  
end
