class AdditionalInfosController < ApplicationController
  before_action :set_additional_info, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_admin

  # GET /additional_infos
  # GET /additional_infos.json
  def index
    if params[:subject_id] && params[:subject_id] != ''
      @additional_infos = AdditionalInfo.for_class(current_class).for_subject(params[:subject_id]).limit(10)
    else
      @additional_infos = AdditionalInfo.for_class(current_class).limit(10)
    end

    respond_to do |format|
      format.html { render 'additional_infos/index.html.erb' }
      format.js {
        if params[:source] == 'form' && params[:item_type]
          params[:additional_infos] = {}
          if params[:item_id] && params[:item_id] != ''
            # editing => load already ticked infos
            item = GenericUtuItem.find_instance(params[:item_id], params[:item_type])
            item.info_item_bindings.each do |penis|
              params[:additional_infos][penis.additional_info.id] = 1
            end
          end
          @subject = Subject.find(params[:subject_id])
          @item_type = params[:item_type]
          render 'additional_infos/index/form_index'
        else
          render 'additional_infos/index/full_index'
        end
      }
    end
  end

  # GET /additional_infos/1
  # GET /additional_infos/1.json
  def show
  end

  # GET /additional_infos/new
  def new
    @additional_info = AdditionalInfo.new
    @additional_info.sclass = current_class
  end

  # GET /additional_infos/1/edit
  def edit
  end

  # POST /additional_infos
  # POST /additional_infos.json
  def create
    @additional_info = AdditionalInfo.new(additional_info_params)

    respond_to do |format|
      if @additional_info.save
        format.html { redirect_to additional_infos_path, notice: 'Additional info was successfully created.' }
        format.json { render :show, status: :created, location: @additional_info }
      else
        format.html { render :new }
        format.json { render json: @additional_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /additional_infos/1
  # PATCH/PUT /additional_infos/1.json
  def update
    respond_to do |format|
      if @additional_info.update(additional_info_params)
        format.html { redirect_to additional_infos_path, notice: 'Additional info was successfully updated.' }
        format.json { render :show, status: :ok, location: @additional_info }
      else
        format.html { render :edit }
        format.json { render json: @additional_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /additional_infos/1
  # DELETE /additional_infos/1.json
  def destroy
    @additional_info.destroy
    respond_to do |format|
      format.html { redirect_to additional_infos_url, notice: 'Additional info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_additional_info
    @additional_info = AdditionalInfo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def additional_info_params
    params.require(:additional_info).permit(:name, :url, :subject_id, :sclass_id)
  end
end
