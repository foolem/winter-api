class SubAreasController < ApplicationController
  before_action :set_sub_area, only: [:show, :update, :destroy, :preferences]
  before_action :authenticate_user!
  # GET /sub_areas
  def index
    @sub_areas = SubArea.all

    render json: @sub_areas, each_serializer: SubAreaSerializer
  end

  # GET /sub_areas/1
  def show
    render json: @sub_area, serializer: SubAreaSerializer
  end

  # POST /sub_areas
  def create
    @sub_area = SubArea.new(sub_area_params)

    if @sub_area.save
      render json: @sub_area, status: :created, serializer: SubAreaSerializer
    else
      render json: @sub_area.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sub_areas/1
  def update
    if @sub_area.update(sub_area_params)
      render json: @sub_area, serializer: SubAreaSerializer
    else
      render json: @sub_area.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sub_areas/1
  def destroy
    @sub_area.destroy
  end

  def preferences
    render json: @sub_area.preferences, status: :ok, each_serializer: PreferenceSerializer
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub_area
      @sub_area = SubArea.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sub_area_params
      params.require(:sub_area).permit(:name, :area_id, :sub_area_id)
    end
end
