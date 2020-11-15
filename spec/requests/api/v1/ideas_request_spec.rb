# frozen_string_literal: true

require "rails_helper"

RSpec.describe "IdeasAPI", type: :request do
  describe "Index" do
    before do
      # リクエストするCategoryのideaを生成
      @category = create(:category)
      @ideas = create_list(:idea, 3, category: @category)
      # リクエストするCategoryではないideaを生成
      other_category = create(:category)
      @other_idea = create(:idea, category: other_category)
    end

    context "params:[category_name:]がある場合" do
      it "リクエストされたcategoryに対応するideaを取得する" do
        get "/api/v1/ideas", params: { category_name: @category.name }
        # @ideasは含まれるが、@other_ideaは含まれない
        expect(response.body).to include(@ideas.first.body)
        expect(response.body).not_to include(@other_idea.body)
        json = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(json["data"].length).to eq(3)
      end

      it "リクエストされたcategoryが存在しない場合" do
        get "/api/v1/ideas", params: { category_name: "not_exist_category" }
        expect(response.status).to eq(404)
      end
    end

    context "params:[category_name:]がない場合" do
      it "全てのideaを取得する" do
        get "/api/v1/ideas"
        # @ideasも@other_ideaも含まれる
        expect(response.body).to include(@ideas.first.body)
        expect(response.body).to include(@other_idea.body)
        json = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(json["data"].length).to eq(4)
      end
    end
  end

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
