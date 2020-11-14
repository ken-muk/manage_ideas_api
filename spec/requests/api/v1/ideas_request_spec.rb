require 'rails_helper'

RSpec.describe "IdeasAPI", type: :request do
  describe "Create" do
    context "paramsが存在する場合" do
      it "既存のCategoryに新しいIdeaを追加する" do
        # Categoryは追加されず、Ideaは追加される
        category = create(:category)
        expect {
          post "/api/v1/ideas", params: { category_name: category.name, body: "idea" }
        }.to change(Category, :count).by(0).and change(Idea, :count).by(+1)
        expect(response.status).to eq(201)
      end

      it "CategoryとIdeaの両方を新規作成する" do
        # CategoryもIdeaも追加される
        expect {
          post "/api/v1/ideas", params: { category_name: "category", body: "idea" }
        }.to change(Category, :count).by(+1).and change(Idea, :count).by(+1)
        expect(response.status).to eq(201)
      end
    end

    context "paramsが空文字の場合" do
      it "category_nameが空文字" do
        expect {
          post "/api/v1/ideas", params: { category_name: "", body: "idea" }
        }.to change(Category, :count).by(0).and change(Idea, :count).by(0)
        expect(response.status).to eq(422)
      end
      it "ideaのbodyが空文字" do
        expect {
          post "/api/v1/ideas", params: { category_name: "category", body: "" }
        }.to change(Category, :count).by(0).and change(Idea, :count).by(0)
        expect(response.status).to eq(422)
      end
      it "category_name、ideaのbodyが両方空文字" do
        expect {
          post "/api/v1/ideas", params: { category_name: "", body: "" }
        }.to change(Category, :count).by(0).and change(Idea, :count).by(0)
        expect(response.status).to eq(422)
      end
    end
  end
end
