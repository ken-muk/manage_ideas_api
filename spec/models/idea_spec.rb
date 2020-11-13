require 'rails_helper'

RSpec.describe Idea, type: :model do
  let(:idea) { create(:idea) }

  describe "Idea" do
    describe "バリデーションチェック" do
      it "bodyとcategory_idが設定されていればOK" do
        expect(idea.valid?).to eq(true)
      end

      it "bodyが空文字だとNG" do
        idea.body = ""
        expect(idea.valid?).to eq(false)
      end

      it "bodyがnilだとNG" do
        idea.body = nil
        expect(idea.valid?).to eq(false)
      end

      it "category_idがnilだとNG" do
        idea.category_id = nil
        idea.save
        expect(idea.valid?).to eq(false)
      end
    end
  end
end
