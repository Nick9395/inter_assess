class PracticesController < ApplicationController
  before_action :authenticate_user!

  def new
    return unless ready_to_start?

    @practice = ::Practice.new(question_count: ::Practice::QUESTION_COUNT_RANGE.min)
  end

  def create
    return unless ready_to_start?

    # 開発時の再読込では、素の PracticeStarter が PracticesController::PracticeStarter を探す
    @practice = ::PracticeStarter.new(
      user: current_user,
      question_count: practice_params[:question_count]
    ).call

    if @practice.persisted?
      redirect_to @practice
    else
      render :new, status: :unprocessable_content
    end
  end

  def show
    @practice = current_user.practices.find(params[:id])
    @turn = @practice.current_turn
  end

  private

  def practice_params
    params.require(:practice).permit(:question_count)
  end

  def ready_to_start?
    unless current_user.profile_present?
      redirect_to edit_profile_path, alert: "先に学歴または職歴を登録してください。"
      return false
    end

    ongoing = current_user.in_progress_practice
    if ongoing
      redirect_to ongoing, notice: "進行中の面談があります。"
      return false
    end

    true
  end
end
