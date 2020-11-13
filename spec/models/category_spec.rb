# frozen_string_literal: true

require "rails_helper"

RSpec.describe Category, type: :model do
  let(:category) { build(:category) }

  describe "Category" do
    describe "バリデーションチェック" do
      it "titleが設定されていればOK" do
        expect(category.valid?).to eq(true)
      end

      it "titleが空文字だとNG" do
        category.title = ""
        expect(category.valid?).to eq(false)
      end

      it "titleがnilだとNG" do
        category.title = nil
        expect(category.valid?).to eq(false)
      end
    end

    describe "ユニーク制約チェック" do
      it "titleが一意であることを確認" do
        category = Category.create(title: "test")
        dup_category = Category.create(title: category.title)
        expect(dup_category).not_to be_valid
      end
    end
  end
end
