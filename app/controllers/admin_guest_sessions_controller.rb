# app/controllers/admin_guest_sessions_controller.rb

class AdminGuestSessionsController < ApplicationController
  def create
    #binding.pry
    user = User.find_by(email: 'admin@example.com')

    if user.nil?
      user = User.new(email: 'admin@example.com', admin: true, password: SecureRandom.urlsafe_base64)
      user.save(validate: false)
    end

    sign_in user
    redirect_to posts_path, notice: '管理者としてログインしました。'
  end
end
