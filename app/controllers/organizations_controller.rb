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
  
  def city
    
  end
  
  def search
    request=params[:starts]+'%'
    @res=Organization.select(:id,:name).where("name LIKE ?",request)
    respond_to do |format|
      format.html {render "404"}
      format.json {render json: @res}
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
  
  def destroy
    @organization=Organization.find(params[:id])
    if @organization.people.count==0
      if @organization.destroy
        flash[:success]="Organization deleted"
      else
        flash[:error]="Error while deleting organization"
      end
    else
      flash[:error]="Deleting unsuccessfull (workers>0)"
    end
    redirect_to(organizations_path)
  end
  
  private
  
    def organization_params
      params.require(:organization).permit(:name)
    end
end