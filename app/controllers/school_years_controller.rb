class SchoolYearsController < ApplicationController
  before_action :set_school_year, only: [:show, :edit, :update, :destroy, :generate_services_from]

  # GET /school_years
  # GET /school_years.json
  def index
    @school_years = SchoolYear.all
  end

  # GET /school_years/1
  # GET /school_years/1.json
  def show
  end

  # GET /school_years/new
  def new
    @school_year = SchoolYear.new
  end

  # GET /school_years/1/edit
  def edit
  end

  # POST /school_years
  # POST /school_years.json
  def create
    @school_year = SchoolYear.new(school_year_params)

    respond_to do |format|
      if @school_year.save
        format.html { redirect_to @school_year, notice: 'School year was successfully created.' }
        format.json { render :show, status: :created, location: @school_year }
      else
        format.html { render :new }
        format.json { render json: @school_year.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /school_years/1
  # PATCH/PUT /school_years/1.json
  def update
    respond_to do |format|
      if @school_year.update(school_year_params)
        format.html { redirect_to @school_year, notice: 'School year was successfully updated.' }
        format.json { render :show, status: :ok, location: @school_year }
      else
        format.html { render :edit }
        format.json { render json: @school_year.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /school_years/1
  # DELETE /school_years/1.json
  def destroy
    @school_year.destroy
    respond_to do |format|
      format.html { redirect_to school_years_url, notice: 'School year was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def generate_services_from
    date = Date.parse(params[:date])
    group_category_criteria = GroupCategory.find(params[:group_category_id])
    sclass = Sclass.find(params[:sclass_id])

    first_group = group_category_criteria.sgroups.first
    second_group = group_category_criteria.sgroups.last

    first_mate_array = sclass.class_members.joins(group_belongings: :sgroup).where("sgroups.id = ?", first_group.id).to_a
    second_mates_array = sclass.class_members.joins(group_belongings: :sgroup).where("sgroups.id = ?", second_group.id).to_a

    @created_services = []

    @school_year.services.where(sclass_id: sclass.id).destroy_all

    end_of_year = Date.new(@school_year.beginning_year + 1, 6, 30)
    next_monday = date - (date.wday - 1).days

    if next_monday >= Date.new(@school_year.beginning_year, 9, 1) && next_monday < end_of_year
      # date is in current school year

      mates_used = true

      date_for_cycle = next_monday
      while date_for_cycle < end_of_year

        if mates_used
          # reload mates when new holiday object was created
          first_mate = first_mate_array.delete_at(rand(first_mate_array.length))
          second_mate = second_mates_array.delete_at(rand(second_mates_array.length))
          mates_used = false
        end

        end_of_school_week = date_for_cycle + 4.days
        holidays = @school_year.holidays.where("(holiday_beginning BETWEEN :start_date AND :end_date OR holiday_end BETWEEN :start_date AND :end_date) OR (holiday_beginning < :start_date AND holiday_end > :end_date)", {start_date: date_for_cycle, end_date: end_of_school_week})
        if holidays.exists?
          # holidays detected

          # sum up the ar- FUCK IT MULTIPLE HOLIDAYS WITHIN ONE WEEK NOT SUPPORTED!!!
          if holidays.first.holiday_beginning > date_for_cycle
            # holidays begin after monday = squeeze one more service in but keep the same pair of people
            @created_services << Service.create!(sclass_id: sclass.id, school_year_id: @school_year.id, service_start: date_for_cycle, service_end: holidays.first.holiday_beginning - 1.days, first_mate_id: first_mate.id, second_mate_id: second_mate.id)
            mates_used = true
          end

          if holidays.first.holiday_end < end_of_school_week
            # holidays end before friday = squeeze one more service in but keep the same pair of people
            @created_services << Service.create!(sclass_id: sclass.id, school_year_id: @school_year.id, service_start: holidays.first.holiday_end + 1.days, service_end: end_of_school_week, first_mate_id: first_mate.id, second_mate_id: second_mate.id)
            mates_used = true
          end
        else
          # no holidays, just set the whole week
          @created_services << Service.create!(sclass_id: sclass.id, school_year_id: @school_year.id, service_start: date_for_cycle, service_end: end_of_school_week, first_mate_id: first_mate.id, second_mate_id: second_mate.id)
          mates_used = true
        end
        date_for_cycle += 7.days

        # out of mates? just fetch new ones from database
        if first_mate_array.size == 0
          first_mate_array = sclass.class_members.joins(group_belongings: :sgroup).where("sgroups.id = ?", first_group.id).to_a
        end
        if second_mates_array.size == 0
          second_mates_array = sclass.class_members.joins(group_belongings: :sgroup).where("sgroups.id = ?", second_group.id).to_a
        end
      end
    end

    render 'school_years/service_generation_report'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_school_year
    @school_year = SchoolYear.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def school_year_params
    params.require(:school_year).permit(:beginning_year)
  end
end
