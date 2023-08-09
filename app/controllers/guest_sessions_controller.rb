# app/controllers/guest_sessions_controller.rb
class GuestSessionsController < ApplicationController
  def create
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.skip_confirmation!  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
    # ここではセッションを作成せず、単に閲覧用のロジックを実行します
    # 例: 特定の閲覧用アクションを実行
  end
end
