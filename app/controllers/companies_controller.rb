class CompaniesController < ApplicationController
  before_action :set_company, except: %i[index create new]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def show; end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to companies_path, notice: 'Saved'
    else
      flash[:alert] = @company.errors.full_messages.join(',').to_s
      render :new
    end
  end

  def edit; end

  def update
    if @company.update(company_params)
      redirect_to companies_path, notice: 'Changes Saved'
    else
      flash[:alert] = @company.errors.full_messages.join(',').to_s
      render :edit
    end
  end

  def destroy
    @company.destroy
    redirect_to companies_path, notice: 'Company Destroy'
  end

  private

  def company_params
    params.require(:company).permit(
      :name,
      :legal_name,
      :description,
      :zip_code,
      :phone,
      :email,
      :owner_id
    )
  end

  def set_company
    @company = Company.find_by(id: params[:id])
    redirect_to companies_path, notice: 'Company Not Found' if @company.blank?
  end
end
