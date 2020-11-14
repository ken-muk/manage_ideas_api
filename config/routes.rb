# frozen_string_literal: true

Rails.application.routes.draw do
  # バージョン管理をわかりやすくために、名前空間の作成
  namespace "api" do
    namespace "v1" do
      resources :ideas
    end
  end
end
