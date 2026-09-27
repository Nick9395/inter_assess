class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    pad_entries
  end

  def update
    if current_user.update(profile_params)
      redirect_to edit_profile_path, notice: "プロフィールを保存しました。"
    else
      pad_entries
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    current_user.education_entries.destroy_all
    current_user.work_entries.destroy_all
    redirect_to edit_profile_path, notice: "プロフィールを削除しました。"
  end

  private

  def pad_entries
    current_user.education_entries.build while current_user.education_entries.size < User::MAX_EDUCATION_ENTRIES
    current_user.work_entries.build while current_user.work_entries.size < User::MAX_WORK_ENTRIES
  end

  def profile_params
    params.require(:user).permit(
      education_entries_attributes: [
        :id, :enrolled_on, :school_name, :faculty, :graduated_on, :learned, :position, :_destroy
      ],
      work_entries_attributes: [
        :id, :joined_on, :left_on, :company_description, :role, :achievement, :position, :_destroy
      ]
    )
  end
end
