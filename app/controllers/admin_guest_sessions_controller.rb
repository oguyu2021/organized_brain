# app/controllers/admin_guest_sessions_controller.rb
class AdminGuestSessionsController < ApplicationController
  def create
    user = User.find_or_create_by!(email: 'admin@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.skip_confirmation!  # Confirmable を使用している場合は必要
    end
    sign_in user
    redirect_to root_path, notice: '管理者としてログインしました。'
  end
end
