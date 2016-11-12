class SchedulesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def new
    @schedule = Schedule.new()
    @subject_list = Course.uniq.pluck(:name)
    respond_to do |format|
      format.html
      format.json { render json: @subject_list }
    end
  end

  def create
    sched = schedule_params
    sched[:mon_class] = params[:mon_class] ? params[:mon_class] : 0
    sched[:sat_class] = params[:sat_class] ? params[:sat_class] : 0
    subjects = sched[:subjects].split(/\r\n/)
    sched[:subjects] = subjects
    @schedule = Schedule.new(sched)
    @schedule.save
    redirect_to schedule_path(@schedule)
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  private
  def schedule_params
    params.require(:schedule).permit(:subjects,
                                     :time_start,
                                     :time_end,
                                     :mon_class,
                                     :sat_class,
                                     :breaks)
  end

  def outer_params
    params.permit(:mon_class,
                  :sat_class)
  end
end
