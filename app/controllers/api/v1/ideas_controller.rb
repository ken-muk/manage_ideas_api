# frozen_string_literal: true

module Api
  module V1
    class IdeasController < ApplicationController
      def index
        if params[:category_name]
          if category = Category.find_by(name: params[:category_name])
            serialize_ideas(category.ideas)
            render status: :ok, json: { data: @ideas }
          else
            render status: :not_found
          end
        else
          ideas = Idea.all.includes(:category)
          serialize_ideas(ideas)
          render status: :ok, json: { data: @ideas }
        end
      end

      def create
        idea = Idea.new(idea_params)
        if !(params[:category_name].blank? || params[:body].blank?)
          category = Category.find_or_create_by(name: params[:category_name])
          idea.category_id = category.id
        end

        if idea.save
          render status: :created, json: { data: idea }
        else
          render status: :unprocessable_entity, json: { data: idea.errors }
        end
      end

      private
        def idea_params
          params.permit(:body, :category_id)
        end

        def serialize_ideas(ideas)
          @ideas = []
          ideas.each do |idea|
            hash = { id: idea.id, category: idea.category.name, body: idea.body }
            @ideas = @ideas.push(hash)
          end
        end
    end
  end
end
