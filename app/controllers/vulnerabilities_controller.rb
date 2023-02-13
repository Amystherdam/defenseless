class VulnerabilitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vulnerability, only: %i[show update destroy]

  # GET /vulnerabilities
  def index
    @vulnerabilities = Vulnerability.all

    render json: @vulnerabilities
  end

  # GET /vulnerabilities/1
  def show
    render json: @vulnerability
  end

  # POST /vulnerabilities
  def create
    @vulnerability = Vulnerability.new(vulnerability_params)

    if @vulnerability.save
      render json: @vulnerability, status: :created, location: @vulnerability
    else
      render  json: { error: @vulnerability.errors.full_messages.join(', ') },
              status: :unprocessable_entity
    end
  end

  # PATCH/PUT /vulnerabilities/1
  def update
    if @vulnerability.update(vulnerability_params)
      render json: @vulnerability
    else
      render json: @vulnerability.errors, status: :unprocessable_entity
    end
  end

  # DELETE /vulnerabilities/1
  def destroy
    @vulnerability.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vulnerability
    @vulnerability = Vulnerability.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def vulnerability_params
    params.require(:vulnerability).permit(:name, :description, :impact, :solution, :status, :user_id)
  end
end
