class OrganizationsController < ApplicationController
  
  def index
    @organizations=Organization.paginate(page: params[:page], 
                                               per_page: 10)
  end
  
  def new
    @organization=Organization.new
  end
  
  def create
    @organization=Organization.new(organization_params)
    if @organization.save
      flash[:success]= 'Organization added successfully!'
      redirect_to(organizations_path)
    else
      render 'new'
    end
  end
  
  private
  
    def organization_params
      params.require(:organization).permit(:name)
    end
end