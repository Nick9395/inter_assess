class PracticeAnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @practice = current_user.practices.find(params[:practice_id])

    unless @practice.in_progress?
      redirect_to @practice
      return
    end

    @turn = @practice.current_turn
    if @turn.nil?
      @practice.complete_if_finished!
      redirect_to @practice
      return
    end

    if @turn.update(answer_text: answer_params[:answer_text].to_s.strip)
      @practice.complete_if_finished!
      redirect_to @practice
    else
      render "practices/show", status: :unprocessable_content
    end
  end

  private

  def answer_params
    params.require(:turn).permit(:answer_text)
  end
end
