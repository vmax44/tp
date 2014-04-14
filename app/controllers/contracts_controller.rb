class ContractsController < ApplicationController
   before_filter :authenticate_user!
  
  def index
    @contracts=current_user.contracts.paginate(page: params[:page], 
                                               per_page: 10)
  end

  def new
    @contract=current_user.contracts.new
  end
  
  def create
    @contract=current_user.contracts.new(contract_params)
    if @contract.save
      flash[:success]= 'Policy added successfully!'
      redirect_to(contracts_path)
    else
      render 'new'
    end
  end
  
  def edit
    @contract=current_user.contracts.find(params[:id])
  end
  
  def update
    @contract=current_user.contracts.find(params[:id])
    if @contract.update_attributes(contract_params)
      flash[:success]="Policy updated successfully"
      redirect_to(contracts_path)
    else
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
      params.require(:contract).permit(:id, :number, :strahovatel_id, :zastrahovanniy_id, :cost, 
                                     :date, :datestart, :datefinish)
    end
  
end