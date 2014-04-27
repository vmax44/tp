class ContractsController < ApplicationController
   before_filter :authenticate_user!
  
  def index
    @contracts=current_user.contracts.paginate(page: params[:page], 
                                               per_page: 10)
  end
  


  def new
    @contract=current_user.contracts.new
    @contract.build_strahovatel
    @contract.strahovatel.build_organization
    @contract.build_zastrahovanniy
    @organizations=Organization.all
    
  end
  
  def create
    @contract=current_user.contracts.new(contract_params)

    if @contract.save
      flash[:success]= 'Policy added successfully!'
      redirect_to(contracts_path)
    else
      @organizations=Organization.all
      render 'new'
    end
  end
  
  def edit
    @contract=current_user.contracts.find(params[:id])
    @organizations=Organization.all
  end
  
  def update
    @contract=current_user.contracts.find(params[:id])
    if @contract.update_attributes(contract_params)
      flash[:success]="Policy updated successfully"
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
