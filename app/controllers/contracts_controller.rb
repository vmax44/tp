class ContractsController < ApplicationController
   before_filter :authenticate_user!
  
  def index
    @contracts=current_user.contracts.paginate(page: params[:page])
    
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
      flash.now[:error]= 'Error while saving policy'
      render 'new'
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
                                     :date, :datestart, :datefinish)
    end
  
end
