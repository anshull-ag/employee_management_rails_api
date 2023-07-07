class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :update, :destroy]

  def index
    employees = Employee.all
    render json: employees.to_json
  end

  def show
    render json: @employee.to_json
  end

  def create
    employee = Employee.new(employee_params)
    if employee.save
      render json: employee.to_json, status: :created
    else
      render json: employee.errors.messages, status: :unprocessable_entity
    end
  end

  def update
    if @employee.update(employee_params)
      render json: @employee.to_json
    else
      render json: @employee.errors.messages, status: :unprocessable_entity
    end
  end
  
  def destroy 
    if @employee.destroy
      head :no_content
    else 
      head :unprocessable_entity
    end
  end

  def find_department
    employees = Employee.includes(:department).where(departments: { name: params[:filter] })
    render json: employees, each_serializer: EmployeeSerializer
  end
  
  private
  
  def employee_params
    params.require(:employee).permit(:name, :email, :password, :dob, :qualification, :contact, :gender, :department_id)
  end 

  def set_employee
    @employee = Employee.find(params[:id])
  end
end
