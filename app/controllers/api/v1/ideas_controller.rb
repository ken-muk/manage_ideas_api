# frozen_string_literal: true

module Api
  module V1
    class IdeasController < ApplicationController
      def index
        if params[:category_name]
          if category = Category.find_by(name: params[:category_name])
            ideas = category.ideas
            render status: 200, json: { status: :ok, message: "Selected Category Ideas", data: ideas }
          else
            render status: 404, json: { status: :not_found, message: "Category Not Found" }
          end
        else
          ideas = Idea.all.includes(:category)
          render status: 200, json: { status: :ok, message: "All Ideas", data: ideas }
        end
      end

      def create
        idea = Idea.new(idea_params)
        if !(params[:category_name].blank? || params[:body].blank?)
          category = Category.find_or_create_by(name: params[:category_name])
          idea.category_id = category.id
        end

        if idea.save
          render status: 201, json: { status: :created, data: idea }
        else
          render status: 422, json: { status: :unprocessable_entity, data: idea.errors }
        end
      end

      private
        def idea_params
          params.permit(:body, :category_id)
        end
    end
  end
end
