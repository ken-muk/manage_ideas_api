# frozen_string_literal: true

require "rails_helper"

RSpec.describe Category, type: :model do
  let(:category) { create(:category) }

  describe "Category" do
    describe "バリデーションチェック" do
      it "nameが設定されていればOK" do
        expect(category.valid?).to eq(true)
      end

      it "nameが空文字だとNG" do
        category.name = ""
        expect(category.valid?).to eq(false)
      end

      it "nameがnilだとNG" do
        category.name = nil
        expect(category.valid?).to eq(false)
      end
    end

    describe "ユニーク制約チェック" do
      it "nameが一意であることを確認" do
        category = Category.create(name: "test")
        dup_category = Category.create(name: category.name)
        expect(dup_category).not_to be_valid
      end
    end
  end
end
