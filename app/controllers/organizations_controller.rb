class OrganizationsController < ApplicationController
  
  def index
    if current_user.nil?
      @organizations=Organization.paginate(page: params[:page], 
                                               per_page: 10)
    else
      @organizations=current_user.organizations.paginate(page: params[:page],
                                               per_page: 10)
    end
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
  
  def edit
    @organization=Organization.find(params[:id])
  end
  
  def update
    @organization=Organization.find(params[:id])
    if @organization.update_attributes(organization_params)
      flash[:success]="Organization updated successfully"
      redirect_to(organizations_path)
    else
      render 'edit'
    end
  end
  
  private
  
    def organization_params
      params.require(:organization).permit(:name)
    end
end