class SchedulesController < ApplicationController
  before_action :find_schedule
  
  def update
    return render json: { message: 'Schedule updated successfully' }, status: 200 if @schedule.update(schedule_params)

    render json: { message: 'Could not update the schedule' }, status: 400
  end

  def destroy
    return render json: { message: 'Schedule cancelled successfully' }, status: 200 if @schedule.destroy

    render json: { message: 'Could not cancel the schedule' }, status: 400
  end

  private

  def schedule_params
    params.require(:schedule).permit(:begin_time, :end_time)
  end

  def find_schedule
    @schedule = Schedule.find_by_id(params[:id])
  end
end
